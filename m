Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A13606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iOuG+jXe;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IasK0K7y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CECD810E6;
	Wed, 21 Oct 2026 04:08:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OXeKpLRvsqvu; Wed, 21 Oct 2026 04:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 07D47810E8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792555705;
	b=Tctsusi3xTnct3QEW0B90nAvGumTT2UAf8Fw4CLJtj2zP+iI0EvoD0Wt+LqfUg31+by/
	 R9ylsLWw94lS/Kr27FXQT9BUJeKXqJempM9SeycNXYb2m7yWFt50CUsLI5cara9n4mD5T
	 fKc5+oJxThqbzcbpk/q6Nf37e9dOdNJfHw6ZJaYWHxm8a3y0EyTtPmsVoJ6SqsHNhMbLj
	 vGxuW5BmCZDE5HcPJmIVub6Ims6EI+PR+KhYRex3P4wZMmtVCKU83jmZUgyuuW6vjHYot
	 05ORbGn1HMZVT/S2SK8i4wwMHaiVe+QUGsWxRCBrpg83hDtY+fNtDCzT5f1i6zdU52g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792555705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Virus-Scanned:X-Virus-Status:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N3jvwh5V6yd70inWnaB8bf1ZHKAg63jldWC7ROqieTU=;
	b=na6lnhQro4vFIiXljm0I9woZNIOerH3q/iqSfv5Fx/fGAhuWTHr1q9WwzvHeseHU9lhh
	 AO0n6DwNMQhGPdCb8asC3H6mj088DFecrtrcKjPbTVdb5XEkFeXVUkRSd2Ap2+iXr7P2Z
	 qxFNlvsAmUZef67D82pC0qzF0AjgXjZ1FovMs75jdR6IP3lo0F4nDMeFhPznCPotpw2q4
	 CKG4PZ6lCklkJsKxEmPUXE9TQVTgLuA2RZlOhJtWGbTQSWydkC5aotRDwG+guea7KOuMn
	 yytDqsMAGE1stG8C//tYjg1x5mglgLepYP3kEYWT7CXWT7YproENJStn/jkryzbi4Qg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792555705;
	bh=N3jvwh5V6yd70inWnaB8bf1ZHKAg63jldWC7ROqieTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iOuG+jXeInZTerpnoXEWWR7D0SFWO8gozOwyZRN4ecusQewsc8tzPPtqiaGoxvqDC
	 Qzb0K/cJ+3sH4t5LuPj9cYf94bcLpMv02Zbuul2pUxg9ZAy5ZEdeNenhA74jM7SFom
	 1BIQIVsXIrMtrJyFNw9yQRhGdl0UyFC/gB1cMSKEcgyxCx9yAKKJ4nuYgL9JynSR3F
	 UivGGXdj9zcD7KBhMsaPB54US+T+ApStosfWnReInRKJag5+ybsRLkmnGUGRCoV9Tr
	 R9Gf96a09ul4Y8VQu4OqzWZ0SxrTD6WtOdbXfhcGItMT+iIDgXXfi9Omn5Ii1aRQKA
	 HVYD7TGRCC2kA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07D47810E8;
	Wed, 21 Oct 2026 04:08:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B3B1930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CACE60712
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZBYfWjXIAP6f for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:54:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5DF0F6070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792518855;
 b=X14Y20N7HKylibQ3ggIjN7kCU/OL9HBj1UqvcTbmA0bHz0MZzZD+kLI04A6lE08h88eC
 eLJYUEPtX50KONxaD5puLjl8zMEuZ3TgrWPnY89IVsET+5Rc1pcW0oIW1OPIfwFm9sIvL
 U9Xz4MSNNPHkg4n+yfptyJtiaVQVNtuv7BfWtBpE1VLTtBYBzHIq/BOO+lFKjraxABAAz
 Z+z7RnSWKIe+Fgoh0jwvugy9oAkhB4GLYHm3G/chNxT1RnqkfLmtNQYamss4T8CwbBvJJ
 PaGCdAUvYvnmtIyffx8XibfLHxeVpQCliDKI19c3LKVDX4EwIBIXIHT9cdAJ3YdEH3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792518855;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:X-Virus-Scanned:X-Virus-Status;
 bh=N3jvwh5V6yd70inWnaB8bf1ZHKAg63jldWC7ROqieTU=;
 b=p1WohprWVkSt35TPiomtfrNBjGVAzTMwa4NSW5C+p2gHUqoHxtawGoLXR+DVbtuUSuG8
 xFdRqOqns32TE67ck6j0C7VpHvWmqbHWmJq9pHYGNA2rAYgMjn/VrhY6v3LIERYeYXY56
 7NjkOO2ZV4htpk0UCMfURQITBhAzzcRHhThkuaR2z5oz46zrlQ+lep6QUJt54ntYkcwRL
 HR3hxlguwAog3m2tz/4YbTkzymb7ASPgJe2g9j0/+QtqEGZ930Z1ObvS45LsegLhfCpib
 jnfPmzetRnDp4wJfO5d5t/mfy1hCGi+kQMb/IbXRA8q1xD1s9zocSxfXuQCzPx/m8NA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IasK0K7y; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=nimeshacharya197@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=IasK0K7y
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DF0F6070C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:54:14 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A0FA844F6; Tue, 20 Oct 2026 19:54:11 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07CC98056B
 for <u-boot@lists.denx.de>; Tue, 20 Oct 2026 19:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nimeshacharya197@gmail.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6deb848ddd7so2286960eaf.0
 for <u-boot@lists.denx.de>; Tue, 20 Oct 2026 10:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792518842; cv=none;
 d=google.com; s=arc-20260327;
 b=m53Scea55hvkTcdHrgQUm4h06oTBygHKuBJbwGAv60xtcro5ACH2rLMPpWI0AgMmaD
 VCL/X+ILnLA55jNfIajArooXFxOOlVmBDl4dd+fPK0kAY8/6afljIKOAE6Fwy1fpuF94
 OCnNvxpugHmgPk20s8S4xnYl6mLeZz5LYZCaMvvRADa9lvIgZdr9uhjLiKwRBgk0Ehbb
 6WkNtTrFzkym2ZRfPErbmQMXj4/JmX/ri/QCPBlUeosxQntNBLQMvEOvosBABMUrQBKr
 xkY9YT4ihjrciA3hSWOlaAxck5Lse6q/KDacu7JUtH6QNrwvSsMEaqCklnDF1trvGXzh
 lTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N3jvwh5V6yd70inWnaB8bf1ZHKAg63jldWC7ROqieTU=;
 fh=YeH1aYdLTFNjMYBf7WXQKoqj6FIGQ+P6Nix7Vbh9vN8=;
 b=RqLb5b31V8hzvvrKH2jNEqgBTo3wmapT3vPDs+HDQltmxDorS4tE2XNsSJeR55P1T4
 JHgO5wjmP/2blfbl6UTWoH2q7m0yRo/q6OO2vd+fnZutdkaUhh8dwpIUkJqyDjrjc4MH
 4/iiuABBpJiHimNlhgK2A54oD7gthyc4M5EZn6GYDjQRqxc3tJPcJ5UdAwh1jvujbpnb
 hc2GX8k75W2x4GIR1yiBAsB0tuEEMaa9AR9nj/mmRQiKzmud1yZwIlvlT9v76e+PiJ2v
 gJHBGo1DFk9xTm7NrUTa0WUD8xCLSOiPaUjaH1uJi/vRtbiSJ4mdRmi5gn6MSUzTbnsk
 0aNw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792518842; x=1793123642; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N3jvwh5V6yd70inWnaB8bf1ZHKAg63jldWC7ROqieTU=;
 b=IasK0K7yb8gpMee7HalngblB1EaRQzc5QdhFhre/EWvBC2KSk4w4i455RqhhDwIYJU
 uFup8PG8vgcP43kTbUFaqGpmVkyddFNvEhAXU758CdP5Wk9vSAk8J4Np4KwLN92aTzeo
 EJEBETSQTryhZxp7m/gtN8oLaHfFfpIq5S0ZtJlzLK1A5tHUruc1atiajCSG0VoHBYBl
 vsmONtI+vWewsdp1gUTif4ySWkj0PnXADBBf/BMctx7/4MN558U6G+AV5+QHDSyrLESv
 WQrInujEY/MRlJhzOS3L/h6Sexuvb01lVaVumEYni+PANMju8wAGq1/yBgiFNeE4JU7W
 Vf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792518842; x=1793123642;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N3jvwh5V6yd70inWnaB8bf1ZHKAg63jldWC7ROqieTU=;
 b=vCOHDSjRJ66W2WjbZd9lnq6HzzGQ5C73Wo8eUwxL/Bf+aRFNJoBKCe3WUR18xH2Hta
 02vRfu7GuB/revZkmmfGXofYHTbBAcCVaL3oyGcpE4MmB3xJQ5jL0szQNR9eCbPaZ0P0
 EwJXEkOoWifSnQOO73zg7+Y8uFJqN640T4Ln6f1XzcSl/Q4g8CZErNgSRJvy7aR8OUGq
 li8tn32P978rYvcSupdzQlmzOdw5x8BUtU0pjbYMjwemOdqFX5Zvq8oISGRvNDgDWTNR
 4kcSUWfajoBly+dZFsM3QaKptw0dtm2AFI4g/yrrPH2yjMQ2q+HGa6f6KpZ9KjlyA2Tq
 /oZA==
X-Gm-Message-State: AFq9FYLNenE1GbzBOJTbtc9CG+ts+4ReqJVMZM0zT5/8m0nuJ7PeDxER
 ir4lLjJ855qYpEwK/c2MMQX6SY6skEWuAQfqeIX/SlYeqTNl5Htumo9JvjTBHRKrsbG/tvT4W+g
 mgMffnTcWbwEAwWNkx1t2QPjyYanLK9U=
X-Gm-Gg: AYBFou37lAjrEnpoAozu7diSr8sFt+AJGbvVZOZfrwR7Ky/wlNVRd++waUXidDCLGqI
 flZKARorHB76N+4o7mhSikwY/JTZoc2UbhEQzO7nkjo03AmpDg3+ZKyMyY3Z7k41rGn4WofkAAd
 MGsobcM8TXzJnwXeXILsh+/xOS7JjMLqKd2+yWGQEngMj1jadRZzBdB3pQV0STQqMQpJVUnGNAX
 goy43aq2wTxo1PSQatBMyL32407kEay5kmgnkPh0cMCeJkAWfAeiYNk8sipyIts6ob/Jh2NA3Zq
 J0WEwWfZMRWEQQdSh1EGH8arHurQUgMCQnJEkbgQaNKv7YWxbdwm+Eo=
X-Received: by 2002:a05:6820:98b:b0:6e2:7e9:24e5 with SMTP id
 006d021491bc7-70356aa5559mr8126907eaf.46.1792518842445; Tue, 20 Oct 2026
 10:54:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020091125.4015-1-nimeshacharya197@gmail.com>
 <CAC928HbqsAmo0QXE8HPtbs7q5q0AyUgKCmR2zmkvdb8r8+CYqA@mail.gmail.com>
In-Reply-To: <CAC928HbqsAmo0QXE8HPtbs7q5q0AyUgKCmR2zmkvdb8r8+CYqA@mail.gmail.com>
From: Nimesh Acharya <nimeshacharya197@gmail.com>
Date: Tue, 20 Oct 2026 23:23:51 +0530
X-Gm-Features: AclHuK_a_qgG5-rv3tNlCwJrcy2AhjNTHqtRcOhO-NtHi3_HQXA-Z6masryLP90
Message-ID: <CAMb=oEbYg4mL8NSkbGDFqy9goBNNjuFR+HuGTioQoH=mSfiqtA@mail.gmail.com>
Subject: Re: [PATCH v2] configs: socfpga_de10_standard: Fix raw partition
 booting from SDMMC
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.denx.de, hsnaves@gmail.com, marek.vasut+socfpga@mailbox.org, 
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@altera.com, 
 trini@konsulko.com
Content-Type: multipart/alternative; boundary="000000000000db7364065e49509f"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 21 Oct 2026 04:08:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000db7364065e49509f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct, 2026, 10:42=E2=80=AFpm Massimo Pegorer, <
massimo.pegorer+oss@gmail.com> wrote:

> Hi Nimesh,
>
> Il giorno mar 20 ott 2026 alle ore 15:21 Nimesh Acharya
> <nimeshacharya197@gmail.com> ha scritto:
> >
> > When using the default meta-intel-fpga configuration in Yocto
> > 6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load
> > U-Boot from the raw a2 partition on the SDMMC device.
> >
> > This change configures SPL to locate the raw U-Boot image using the
> > partition type and data offset, rather than relying on the
> > default offset relative to the beginning of the SD card.
> >
> > Signed-off-by: Nimesh Acharya <nimeshacharya197@gmail.com>
> > ---
> > Changes in v2:
> >  - Remove CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2 since =
its
> already the default.
> >
> >  configs/socfpga_de10_standard_defconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/configs/socfpga_de10_standard_defconfig
> b/configs/socfpga_de10_standard_defconfig
> > index 04f9d6c8494..f01667420a0 100644
> > --- a/configs/socfpga_de10_standard_defconfig
> > +++ b/configs/socfpga_de10_standard_defconfig
> > @@ -70,3 +70,7 @@ CONFIG_USB_GADGET_DWC2_OTG=3Dy
> >  CONFIG_USB_GADGET_DOWNLOAD=3Dy
> >  # CONFIG_SPL_WDT is not set
> >  CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy
> > +
> > +# SPL Fails to load UBOOT without these!
> > +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=3Dy
> > +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=3D0x200
> > --
> > 2.56.0
> >
>
> You do not have to edit bye hand the
> configs/socfpga_de10_standard_defconfig.
>
> Instead, run a "make socfpga_de10_standard_defconfig menuconfig", select
> the MMC
> raw mode that you need (by partition type instead of by sector), run a
> "make
> savedefconfig", and move the defconfig file generated in the output
> directory
> to configs/socfpga_de10_standard_defconfig. Then, you will have the patch
> proposal to submit. Something like:
>
> --- a/configs/socfpga_de10_standard_defconfig
> +++ b/configs/socfpga_de10_standard_defconfig
> @@ -27,6 +27,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy
>  CONFIG_CLOCKS=3Dy
>  CONFIG_SPL_PAD_TO=3D0x10000
>  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000
>  CONFIG_SYS_MAXARGS=3D32
>
> Note that there is no CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
> option
> value specified in the defconfig. This value is not used at all when "by
> partition type" mode is selected. Indeed, as you can see in the Kconfig,
> this
> config option depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR which is
> alternative to CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE one.
>
> Regards,
> Massimo
>

Thank you for the suggestions. I have used menuconfig and savedefconfig to
generate the required configuration. I have issued V3 to fix this.

>

--000000000000db7364065e49509f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, 20 Oct, 2026, 10:42=E2=80=AFpm M=
assimo Pegorer, &lt;<a href=3D"mailto:massimo.pegorer%2Boss@gmail.com">mass=
imo.pegorer+oss@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">Hi Nimesh,<br>
<br>
Il giorno mar 20 ott 2026 alle ore 15:21 Nimesh Acharya<br>
&lt;<a href=3D"mailto:nimeshacharya197@gmail.com" target=3D"_blank" rel=3D"=
noreferrer">nimeshacharya197@gmail.com</a>&gt; ha scritto:<br>
&gt;<br>
&gt; When using the default meta-intel-fpga configuration in Yocto<br>
&gt; 6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load<br>
&gt; U-Boot from the raw a2 partition on the SDMMC device.<br>
&gt;<br>
&gt; This change configures SPL to locate the raw U-Boot image using the<br=
>
&gt; partition type and data offset, rather than relying on the<br>
&gt; default offset relative to the beginning of the SD card.<br>
&gt;<br>
&gt; Signed-off-by: Nimesh Acharya &lt;<a href=3D"mailto:nimeshacharya197@g=
mail.com" target=3D"_blank" rel=3D"noreferrer">nimeshacharya197@gmail.com</=
a>&gt;<br>
&gt; ---<br>
&gt; Changes in v2:<br>
&gt;=C2=A0 - Remove CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2 =
since its already the default.<br>
&gt;<br>
&gt;=C2=A0 configs/socfpga_de10_standard_defconfig | 4 ++++<br>
&gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt;<br>
&gt; diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga=
_de10_standard_defconfig<br>
&gt; index 04f9d6c8494..f01667420a0 100644<br>
&gt; --- a/configs/socfpga_de10_standard_defconfig<br>
&gt; +++ b/configs/socfpga_de10_standard_defconfig<br>
&gt; @@ -70,3 +70,7 @@ CONFIG_USB_GADGET_DWC2_OTG=3Dy<br>
&gt;=C2=A0 CONFIG_USB_GADGET_DOWNLOAD=3Dy<br>
&gt;=C2=A0 # CONFIG_SPL_WDT is not set<br>
&gt;=C2=A0 CONFIG_SYS_TIMER_COUNTS_DOWN=3Dy<br>
&gt; +<br>
&gt; +# SPL Fails to load UBOOT without these!<br>
&gt; +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=3Dy<br>
&gt; +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=3D0x200<br>
&gt; --<br>
&gt; 2.56.0<br>
&gt;<br>
<br>
You do not have to edit bye hand the configs/socfpga_de10_standard_defconfi=
g.<br>
<br>
Instead, run a &quot;make socfpga_de10_standard_defconfig menuconfig&quot;,=
 select the MMC<br>
raw mode that you need (by partition type instead of by sector), run a &quo=
t;make<br>
savedefconfig&quot;, and move the defconfig file generated in the output di=
rectory<br>
to configs/socfpga_de10_standard_defconfig. Then, you will have the patch<b=
r>
proposal to submit. Something like:<br>
<br>
--- a/configs/socfpga_de10_standard_defconfig<br>
+++ b/configs/socfpga_de10_standard_defconfig<br>
@@ -27,6 +27,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=3Dy<br>
=C2=A0CONFIG_CLOCKS=3Dy<br>
=C2=A0CONFIG_SPL_PAD_TO=3D0x10000<br>
=C2=A0CONFIG_SPL_NO_BSS_LIMIT=3Dy<br>
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=3Dy<br>
=C2=A0CONFIG_SPL_SPI_LOAD=3Dy<br>
=C2=A0CONFIG_SYS_SPI_U_BOOT_OFFS=3D0x40000<br>
=C2=A0CONFIG_SYS_MAXARGS=3D32<br>
<br>
Note that there is no CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET opt=
ion<br>
value specified in the defconfig. This value is not used at all when &quot;=
by<br>
partition type&quot; mode is selected. Indeed, as you can see in the Kconfi=
g, this<br>
config option depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR which is<br>
alternative to CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE one.<br>
<br>
Regards,<br>
Massimo<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Thank you for the suggestions. I have used menuconfig and savedefcon=
fig to generate the required configuration. I have issued V3 to fix this.</=
div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000db7364065e49509f--
