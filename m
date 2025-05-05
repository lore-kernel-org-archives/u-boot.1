Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B033EC3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 16:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA75820E1;
	Mon,  5 May 2025 18:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=chewies-net.20230601.gappssmtp.com header.i=@chewies-net.20230601.gappssmtp.com header.b="P0Uxw7ay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52475828C2; Mon,  5 May 2025 15:12:56 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45C6182076
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=raz@chewies.net
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so779104866b.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746450774; x=1747055574;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PLmUJUdgMb4I0FCDdfNItxNNG3T0tV4J7kVIBv0o0U=;
 b=P0Uxw7aysQxfvraIvj1vJt0kwJoFFLpUAWPZEkStbpbczRZtWm1fI2DGO+6siDu/fV
 wTejMPNTX3tgREskhgqBDqilskSlUGpRMccfbzb9xMjfuhAn1QSPRnaZkqspSsO25Ww1
 1GMVotEzu7J7DXcnE8AMim+VwuiQ93tKBL7JcF0WRhhiHACcyz29ge73xwKk5jYMTGjp
 kkpZdUSaRfq4THE32OEydgvvMYp/jnxFVOWI9teXDrsqvCaQGAt1jC9RokS78QF2KrxZ
 4PX6E/K5gDH2Yp33Jk2JNT7LzNBihPBx/ZpolC29cSKBj/J82C7KipyZuYI/EGeIz+ih
 U/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746450774; x=1747055574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PLmUJUdgMb4I0FCDdfNItxNNG3T0tV4J7kVIBv0o0U=;
 b=FUMx5jazLaNnyWD5vIDS4z/b7FuR9ndYvS+0e4Sl8Jzd2rKXNKcArnG3nigR6G29A/
 qgBrEaMsRzSVAgk3dvfKQ09EcdGrEVq3+9AouGuBTrnoaqhy4joTKJMJF6fzkZj557Rb
 QJHZRmiD+BmYj5hvCOJfKBaBP0Lxv5a90PV6EgRdK2G6qgYGqwGFUGAaL9hzryEbCqj+
 +CVoQShIMmPc/PxheJKwMFIx8qvfI4y0y+xWEZjiNL8a+8SfnAGFyXbjldFF7OVQY9x/
 UV7yLzkPy4h7icoQDBp9aBc5oeY6i4zVR69kX5eFLJEBTGoqiRv0xBVobLjA+LhK86zI
 ea9A==
X-Gm-Message-State: AOJu0Yy1AFBBE8CVObfjRKYhjJi/iN5osVcoqz8xyovTNoN0kT77hryI
 X/ac/bFx/0hsx7W8Mpv1Dg8tCRlrVSf4ywh5bW7wYFFnMWmZhplZqqIarzmOIk2k5v0uGfcbPDb
 FzeJUXFNWusGCAaP/j8IfKIkIJIj49uZ2n+Z4
X-Gm-Gg: ASbGncvWjjRf7TCkDu1NrYnSeQm/+NlvhlJaJL5488NGfep0dyrL8t2e/6DqRYhnagy
 W0g3dO3I6O57jFwQfnUb/nrjKY63lWoYvJ7eO3aaWWiPunjDcySYAYuBxqpUx+e9a2zuiRfDHfw
 9Avefw85+LXVfq808vRf4=
X-Google-Smtp-Source: AGHT+IFYElk0llN1ge4pi4ZSXHpMCLLnNKx89JuhozP4HSomsgFEAmnq/9ASvVYW1zWldmmYnM0dnyeW/hjmdTFJlwE=
X-Received: by 2002:a17:907:c1f:b0:ac1:791c:153a with SMTP id
 a640c23a62f3a-ad17af8392cmr1114328266b.27.1746450773558; Mon, 05 May 2025
 06:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
In-Reply-To: <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
From: Wayne Schroeder <raz@chewies.net>
Date: Mon, 5 May 2025 08:12:39 -0500
X-Gm-Features: ATxdqUF4lges0CS6ogY4qszXoi_2lLRibq4vcliRXnEvivpaFf0MHzWf0mKZKmM
Message-ID: <CAEUiLuYBVyLm4HgJG88r1J8RcUu38uEVPbV5c+-ArqjU4aUOAA@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, 
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>, 
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 05 May 2025 18:13:02 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

If I add the usb reset command, it works reliably at reboot, but it
does not work on a fresh power-up with that change.


On Mon, May 5, 2025 at 2:07=E2=80=AFAM <neil.armstrong@linaro.org> wrote:

> I think it's a very long term issue, USB lacks a proper reset at probe on
> warm reset, does USB still work from U-Boot after the reboot ?
>
