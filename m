Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B84D7494E
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 00:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0969891A3;
	Wed, 30 Oct 2024 01:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H+5xfHSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60967891AF; Wed, 30 Oct 2024 01:15:44 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE06890AE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 01:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6e2e3e4f65dso64596477b3.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730247341; x=1730852141; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6SBhz/n7EEAUQSpwbXB+n9Cxdc+aqQbZX/2FmU7o+c=;
 b=H+5xfHSA9nJiTViiTodeG6C5Pe4HH3lgGLVi0f4OInchd5NAiUfguaZuR4eGilKYhi
 tOoqRIaA3wUqRo4hop6ZjIMy0QmyeFUvhHw8xa2HHtLoI/EeWgj8sc7ygFFDB6iBkJEb
 7XtDElhrrUsCeMsoVQs5SMZuLztLnrhkdjSVUp67yKG/O4GiXdRfsA49uqDTIoD7HZsr
 Ye7crt3aruJQ4epf4iSszvFbvrvac1KnIuLwmJEYNABNuAGqWXYr6AeAvOlJTY+CM4QI
 60EPb3J20zlZzFCUfeJSVvyTXEYN9CU4ytAisLHg2EC6OkYtfExKBpF08CreO+C51arw
 8BUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730247341; x=1730852141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6SBhz/n7EEAUQSpwbXB+n9Cxdc+aqQbZX/2FmU7o+c=;
 b=I1zE/JPhgtox9suFsNr0lepkZQ9t30mwURWJHppCPJhwWgVTYT+VopMJEfaCVVjo5V
 D36aIqSiNU19VOzS1ulMA0Uwb7LtJjgiXTdFzBMyHrjgu6hM/bZsthEyJPBIkAA/yqx4
 i46Y3EVk+2Z2jgUCqHlFCPbZy7YmgQR/+G2gp7PwK92/oOPCxhHCdzJPecmTkSmEFLID
 cNkT0+tQgWqZniNOl7CCRJyw2kMNQUihOWs1wjcmYY9JVXirPnGw7qLMQZAKHnfVYHmo
 8HQvNVrkOcMsOAoRhQQYIIri1RFAMhVzieg15Rng6WId6/v+lEWztOCV0zB3Bevf/YIA
 ZtsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzQ1IukEf/vvmXGBno6PYOfkJpZ6upxcflwcBlIEoFPyPZRoIhrIcdqkwa0yEosrNbDTainFQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7VOknwqJfaIIJv61U0bR/+NloZg1QvpxfFDLtUevuurjX+JQR
 4Rjauiyt1vJ916VBZgx6jnLg6lvEo23Azg0NeF120Ut5NxUiBrYhhZ+GDHWeWq3I/aExR/1V0T3
 SVznf84+91bWJZb1Iq5KcIfFynzE=
X-Google-Smtp-Source: AGHT+IEnAw9Ug+iOIKZRSr5xq1AUt8QJqfVTBl+i6eUOtsmeeuM0tMC37cFf+cRvvgeS9wm49TjwmIDxSZ0PJGht3I0=
X-Received: by 2002:a05:690c:7201:b0:652:5838:54ef with SMTP id
 00721157ae682-6e9d8b5144fmr159908887b3.37.1730247341189; Tue, 29 Oct 2024
 17:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241027145241.109809-1-gilles.talis@gmail.com>
 <CAOMZO5BonVeQsZieECmrv7VgStbEeo0bSKoq5FD7vnvvekV_Rw@mail.gmail.com>
In-Reply-To: <CAOMZO5BonVeQsZieECmrv7VgStbEeo0bSKoq5FD7vnvvekV_Rw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Oct 2024 21:15:25 -0300
Message-ID: <CAOMZO5B9gcAxE6Owbiy6vYtKFvDn2cmD6+MEbkPphEN27AtQMQ@mail.gmail.com>
Subject: Re: [PATCH v3] board: emcraft: Add support for Emcraft Systems NavQ+
To: Gilles Talis <gilles.talis@gmail.com>
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, uboot-imx@nxp.com
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

On Sun, Oct 27, 2024 at 6:30=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> This version looks good, thanks:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
