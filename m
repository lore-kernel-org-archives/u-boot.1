Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F188C25B6B
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 02:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E3E087BC4;
	Fri, 27 Oct 2023 04:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hIiOQx/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 238FF87BC4; Fri, 27 Oct 2023 04:11:45 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301D1875EA
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 04:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2800c221af2so173643a91.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 19:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698372699; x=1698977499; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyLnXCaNGyAasf5wkFHF19tYCp3tjt4kchryZLYZ3ig=;
 b=hIiOQx/l77Gb+A/Vqs2FRwUvZoBAAEmT2h9vw+B4mkIb+oRy7ScRb9SqKxt6lqNrAx
 xU+mdlws88gpQgydyCy3c4jSPG4a4basC5dIegMlhgvCcHULETp9ZWXtfaMCEf57gMcu
 eHPMmD5Um7RYMlbCAT3aDmsFJ1YjOzXO6SADDjTV1YfQzujkNpJjEskPJEuwiVkTw9ba
 0EIMBAKswVTDVfw4BDchO5RKDQvlP8m4G6M2lr7IIcoUtk3hgudU9YlNUfJDiS/BBACk
 0axc4xHdWMWdHJaTJ+06z184F7sKr2Ui5kdywD6eSem/RPnwvcXeziPviGOGJXsERe/E
 SfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698372699; x=1698977499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CyLnXCaNGyAasf5wkFHF19tYCp3tjt4kchryZLYZ3ig=;
 b=Cr2XkQ0jYfm4IttJY4nJrIFuCorTvqCV4FnmHdZOrriKZjISkbCdHt+Qbww4Q1glew
 krXDiC62EssljNCW/Y+jhdTfpqhQD5OpX6ggE+HbQ7lx5KntnXWnqcGCAEv48sR0MM1I
 nH5Uujd7FdTH6juIJQlAyJi4gOibDIDGzqbOAvwaGee6YI9znI1mfC0ajr5jd1q/DcEC
 a1DGmDYBquVuUWiixQWwsHgRHsGJkUPCrHwKi4W4NHagdLPeXlT+3AdLNG2IB6oOQIft
 T155iRg51Gs80IXcJNx5ylao2L6k5T0kgGXvcjt0qugdQ5cejLdcn69xtIKgylYIVx+C
 93Mw==
X-Gm-Message-State: AOJu0YzReFQJliR+QzhMUJhdcbMH3rIK5HCum4KaPtoGNH0N99OGRU/U
 UKYGZiZ78gjsLcEVgbFL7YOScPf0oNJScWz/HSVVAxpo
X-Google-Smtp-Source: AGHT+IFQKWcMyCNE5cY3lN6MUPQn87URAXr5wACcLW9v0l7f2KvtQX81doDXgwdTzzsbzt6EY0Ig5hBzoB077QyK0bw=
X-Received: by 2002:a17:90b:1946:b0:27d:8fbd:be8c with SMTP id
 nk6-20020a17090b194600b0027d8fbdbe8cmr1341412pjb.28.1698372699193; Thu, 26
 Oct 2023 19:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231025231311.8701-1-aford173@gmail.com>
 <1001e11f-71e5-4418-8d65-4e9857a08539@denx.de>
In-Reply-To: <1001e11f-71e5-4418-8d65-4e9857a08539@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 26 Oct 2023 21:11:28 -0500
Message-ID: <CAHCN7xLYfMfLW88rdjwOrLRaM0bDvQPLo-KFxwi=x23wj42BDw@mail.gmail.com>
Subject: Re: [PATCH 1/3] configs: rzg2_beacon: Disable the ability to remove
 devices
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 26, 2023 at 8:44=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 10/26/23 01:13, Adam Ford wrote:
> > In order to save some space, disable the ability to dynamically
> > remove devices.  Without this, U-Boot is too large to load without
> > recompiling TF-A.
>
> Did you enable LTO yet ?

Yes.

>
> Striping DM_REMOVE seems like a really bad idea, doesn't that break 'usb
> reset' and its removal of devices ?

I did not, but we can drop this one, and I'll just have to re-compile
TF-A to load a larger U-Boot.

adam
