Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87284C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 12:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D571088650;
	Thu,  4 Jul 2024 14:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S31da3JZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A77885D7; Thu,  4 Jul 2024 14:26:03 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 870F688650
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 14:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52e994be1abso37168e87.2
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720095956; x=1720700756; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsH+7Rc89rPcebSRi0JEjxZdkVVDEvzCQLPYZ8mRNks=;
 b=S31da3JZ1lOzjR7F2rLVlZMsDrXTblP2u+wHpejetAtuvRc+8wykQrW94ngW+70SsU
 nvWW50fIAgwbDhsO3lTW5GJWgRQ1SnuF4FL3M+M5mdn25s6HOiiq4Yr7sGc5EScycDT5
 AG7S7CnZo9AMlT1pmhIrUwhuW6YUGanIDFE9Xcmc5vQhqejcGgYqTEOyaewzPqJr/aGv
 uUePwnwiqqofP4G5k1i1gl1TZN2hUusx/YhOfDoD9Pc2rUZRkozuEwja49H7yrc+fder
 eGU59j0TMAHgXzJrl65C2GQpUP4q2wxfG2Xf2Y4x8Eo8r0lp2GELwgHatpN/1AoQZFfj
 Tmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720095956; x=1720700756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WsH+7Rc89rPcebSRi0JEjxZdkVVDEvzCQLPYZ8mRNks=;
 b=Fpm5SzxlcMZVchVkDDEA1aTr2WCi2pQ3PkjBCWAmPb4GWwjwk+gZPI8UPqk8iHCbbr
 rr7Tjw/it/jqyviBbe6sr3cNhDfGrC5BzezfTpYYLjybRd7uK5ZLFcW609Meb46n5WDm
 KJTHHTDSATns48NM1lrDMTHDEB4gf2r3CTycgosVOu6NtHxSxlqHbobfNPxvbaANZfz/
 fZU6Qw5Ji1VOd39GTMWAU81DrEnmKBm1zHrdcygFuY799qliwBIyLaJb0KqX6veVnfgG
 ZI1TWw7DiJxinGwvHj0chgLUSuruzo1ZmkzK6g+lgeHAL+jj8p2jFqq2wJm9uw453Vo1
 PGHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULfj6dweiY6COZ+ypdgI5UR3J9FE11H+/WQ0apuid1/nrfvQ3y+8E/Gld1LJWJCkHMSX6RNu0M156LglDKaRuYJaYIeQ==
X-Gm-Message-State: AOJu0YxR63iSMTAQi1/D+DmB8283PxON3npk0DRcNBya2oRTJSaWjIqn
 bZCaHqtv5mNBYRvVQAQgrnfidUxcJe5dG0F2i6CbRgmaAmygJfJmNSKa7asZWhY8UvCFdn/xg/R
 8MtSo/6Ex45GcaVR0BCcg/OvbdYJaBg==
X-Google-Smtp-Source: AGHT+IElqRlquvXsNkwG6CYuk+u4q7xsJSFgrfIlkp5hTKDDgJAjxOp1u6i5JueBtQ/fmh46YuWaizCU9frymIojdbA=
X-Received: by 2002:a19:5218:0:b0:52e:9daa:25f4 with SMTP id
 2adb3069b0e04-52ea0641d7cmr962118e87.2.1720095955582; Thu, 04 Jul 2024
 05:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240703175727.446205-1-festevam@gmail.com>
 <20240703180355.GB38804@bill-the-cat>
 <CAOMZO5Dej12iA7mX9MqMrrsj6oQ4SrNCAFN2vGuvOA_sq186aA@mail.gmail.com>
 <20240703182238.GC38804@bill-the-cat>
In-Reply-To: <20240703182238.GC38804@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Jul 2024 09:25:43 -0300
Message-ID: <CAOMZO5BKMhL=K8DxWAZ3fBB-Mpx63QQUX7ycKKA1gJVMcc9ucw@mail.gmail.com>
Subject: Re: [PATCH] msc_sm2s_imx8mp: Adjust the initrd_addr location
To: Tom Rini <trini@konsulko.com>
Cc: ian.ray@gehealthcare.com, sbabic@denx.de, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

Hi Tom,

On Wed, Jul 3, 2024 at 3:22=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> How is the fdt at 0x43000000 not being clobbered if the initramfs at
> 0x43800000 is? Is it because it's just enough of a bad spot that we
> relocate the fdt out of the way? With the kernel at 0x40480000
> everything else is too low. kernel address + 128MiB for fdt address, then
> +512KiB (or a bit more, for nicer numbers) for initrd.

Thanks for the suggestion, it works.

I sent a v2 with that proposal.

Thanks
