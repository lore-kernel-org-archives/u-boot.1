Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3466C624A5
	for <u-boot@archiver.kernel.org>; Sun, 22 Feb 2026 06:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDEF4801BE;
	Sun, 22 Feb 2026 07:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bc0vesx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E91E780FA1; Sun, 22 Feb 2026 02:24:43 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B53D80077
 for <u-boot@lists.denx.de>; Sun, 22 Feb 2026 02:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidzangcs@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-354c825dc77so1441144a91.0
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 17:24:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771723480; cv=none;
 d=google.com; s=arc-20240605;
 b=iSUwZ3xNfvzJSoRmgXgYaqYyAuG+3y09VJLT6Al9K8mJpCpqurAuh7g2p8hkNZshPE
 /pKiJgFVaspolEEJaDQugEKFjt5vtHylXJ+1SdrVZAiN+KO+PjFkQLIr34l12q3ShjXw
 Pf7DP9YpLGfgsHzlu6pGSCvggfw6XSktbf18MEvlzoj45wfZnS8+nOPQmJ/Pbe6CbghG
 fOj5eXa5OkDgmzpI05vWaOAmVm8aIvDzW848FKvqaGsD00R1BVAybY/m5WqrRzNWxZL1
 EakA7BZ+g0p34w6hqqhLKh8NoT0af9l71ouEJI0IJ8JNTwNTEba6/oQ//LmYm5g7YsXM
 WZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UYbXoMq/jjjrAoUT/8KG2FOKCYr5b/b5luJdS8EOlCM=;
 fh=f0Qz8KfqC2xQQmIfpXdAUn9dT4TjWlui+pxA63seHuc=;
 b=i7MPkdsGsnGWzbzd9QX5J2x0QWVcK/b51r4Ly244qFMzM4d+90Xp6s4M2nxWKvzeBI
 K4BUDPFKqBrVzPoqw3XjID1o3QiK+Cpj/do7aY4N5WPnipSwFFIX7whwlnJM4xsLBMQJ
 SwP6dhO6O9JYVmcIIAzBjPPADbWAeQHfmOSyGV3d8QvdBu66aLdcLnQQ+3lay4ph4vQI
 3Lkt7yZ5QTmEZpc/2aGPr3BgTyf9ZvZDkbyr4UeEP1lCvThtXJDjoFHCJlJ5WUHxL6Zu
 AHIGkr2zOTY/2uA0bpkvsZgnKFJrtBr7xAQuVCZczDkknUKA+/K6viTKHPAvxDjBsgdE
 L9WA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771723480; x=1772328280; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UYbXoMq/jjjrAoUT/8KG2FOKCYr5b/b5luJdS8EOlCM=;
 b=bc0vesx8vIHxE78bntrtI0gqxj7uLydANaRgbWsdls4JCkrvTVV0nNhS4kTeuLC2Et
 znqP6XEfsUMXRmeOgRRKdx3wbuHJP8tRsaK5HKcFk12nkImIL7Tx5VifNqLGYUFYZuHF
 UN0WzBsCR61Bxv6xvviGzYFoTmKW/ugiG1mFlpdwkHMRP/Y8NC1xSoh4n7bv2LBCcsxk
 BLuwbhFAiQJgvH88XDfMIRGkG05n76RdKCgjcPsS8DmTnWDeJHjlpBWXyHL8JMr7mesA
 1PJymy4I+6DyoRN/6rF8bPrTHq8zxxkQz7ON2kYDUPwirGXagv6U3QdT2uX8nf+9tdWU
 ewAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771723480; x=1772328280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYbXoMq/jjjrAoUT/8KG2FOKCYr5b/b5luJdS8EOlCM=;
 b=ui0Sv/3xtrh0GfLw358bCgtb4mbAEQqCofVbeXX7l7XYOnVMobPb74TerD+4yvBekB
 /AAm62a/y7+04rDOmYso6o85xcwU4fHrT1Q9lhRQVI/wqbCrMoGw+ht318dQCxVeE18i
 PLHHfJ01DLf+sleGawIcw/8s2EaI2Vxfg7bp8n5H0IPVWEgyrN/c1YWR7GBeqOrI2SKj
 Pd37zXuP8jFrtuPKrmRyYD6/0TCA4DKYU8Y5p97mlsULsEUqx2ec+2o88R1k4fUY7BBC
 ElfI6ETITXY57Ijyh/AlRxENAwanX0Mx3GQuBLAOeCaAYbngxVOqrLqjsCjdZgPBY/18
 j7Gw==
X-Gm-Message-State: AOJu0YwkRQtxRB2L41zqhdQCaFojJnbYqPtbg1d/GFMYZhsPLKHF6thD
 Y6DBlvm8+L19T5lMhxC1ZKbENxau0vGgcWPyXKnk4FGMLbsI7gIhAxx99X/Hrvm74lhgubpTvQM
 KGTKFArsmHxx24kcxt19TiSStQRYp8Yg=
X-Gm-Gg: AZuq6aInYm1MK2o5bcubm42PrpHKcwDzWIVp+jNC3bO93ugIREPBYKbLwP62GahZWPi
 nf3aObOxOow2cUzjJFweTnj2AbPlbnQ4yTIrddrK7iG7ZHMNxIoy5ahgLTY9z3YD9DZQZ6PodUQ
 tu8M3Vigq4QaQ4Us837x3GQYe8iI/aEBAbah/EsCKN4GAAR5m5gyMrnNM6xBosNxl2exvXf8nLk
 hhXQaDPPn1cmRPZGe17Vw96AqnpDXik6Y6QaFoUjU9nERB7lrZCzVnyslYJRUVCw8d31UXPLMXP
 cwzUFgU=
X-Received: by 2002:a17:90a:d407:b0:34c:7182:cf9d with SMTP id
 98e67ed59e1d1-358ae8c6ac1mr3400241a91.25.1771723479749; Sat, 21 Feb 2026
 17:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
 <20260213084956.1031000-2-brian.ruley@gehealthcare.com>
In-Reply-To: <20260213084956.1031000-2-brian.ruley@gehealthcare.com>
From: David Zang <davidzangcs@gmail.com>
Date: Sat, 21 Feb 2026 19:24:28 -0600
X-Gm-Features: AaiRm515e6NL7gFnlxmsZmJRaYSpLYjDcTMox-t4vSbhN76LxgtJdKNTUilkg64
Message-ID: <CACwB3C81mtKZwGyc6=eD5oEhN7zKy4RS_ZR6Z938EmCBA21w4Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] arch: imx: fix incorrect shutdown call for
 inactive video devices
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, Alison Wang <alison.wang@nxp.com>,
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@sysam.it>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Michal Simek <monstr@monstr.eu>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Scott McNutt <smcnutt@psyent.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Wolfgang Denk <wd@denx.de>
X-Mailman-Approved-At: Sun, 22 Feb 2026 07:59:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, Feb 13, 2026 at 2:50=E2=80=AFAM Brian Ruley <brian.ruley@gehealthca=
re.com>
wrote:

> Somehow I missed that ipuv3_fb_shutdown() can be called for inactive
> devices, resulting in invalid memory access and preventing the kernel
> from booting.
>
> Fixes: 32da6773f62 ("video: imx: ipuv3: refactor to use dm-managed state"=
)
> Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - New
>
>  arch/arm/mach-imx/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
>
Reviewed-by: David Zang <davidzangcs@gmail.com>

David
