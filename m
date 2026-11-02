Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834C606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pBPLV6eD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xlUp66H5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F991406AE;
	Mon,  2 Nov 2026 13:10:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o4rSYPv7y7O2; Mon,  2 Nov 2026 13:10:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FF0C40693
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793625036;
	b=X1kJp3xv9LYioB2W+gK/0cIeT9gZUQSK00gnD8ZBGTDA6pGD7mkdb8PrxoUpbJInSLEp
	 RIqEp6SKzcxEtJ1lrpEcj3wj1aDpbFK/cpR2quWyHTH1F51lb6mPX0uCaXob8tACRMgxU
	 320OE3omii9Vv/ESDAC5FrwH9NBIhkxBb32v7e5/+x4c7zszkmGQPRI9hbWPpbh9PEyQB
	 h2NKzCl1f1NNgJYjL9XH1c8b8FVSkGOZkL3rhaqKEP5cq4+wgr+CGe6+WLZy+npr4Urel
	 Iq2C124fHFrMn3oq63XDSrCb07bCJyCpDoPnF22zUC5A5hwz96gHiZNiJkca337g0VA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793625036;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O9/q1tbEwAJ1Lnd76DAyVKn+aeGH08All/wH/mGAuWc=;
	b=iS4QfWHhS3Jtrwzx4Hph4l4vEDtCNdyd6Dy6fdzeHhMki+kiehyzc7WLYjx4O+hEacxf
	 pD3RWSUoLh1LiuIwdOOojBot8PcqMz3tbWod5iySszjrCX17jb4mVL+IZFwopolEHaq2b
	 Zn2ot/HuaZdQoGUlAAm8rmtpCyTAKHKA3QcR2sWELOSTdnzXeaHKyuAAw5wtBQeruJLCg
	 9WBaN6pmlZTlqopiuAjAm12CK9bfym5BaC+ZiutoJyBk8zS0cL5oHNtIdjKa1HOvWN5rS
	 +qWSRRdJ88a49ZelpY5//mOSVDnJqdCqJtOx/9lSE28lEfGEIJPKlNc5WJ4bjE7LdzQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793625036;
	bh=O9/q1tbEwAJ1Lnd76DAyVKn+aeGH08All/wH/mGAuWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pBPLV6eDXvJUCSkDVeNyR3y5dlAtR9sdztcIbvaO41L+kST9xTO/g2xTu93MewKJp
	 zjcGzMFEH1cmtxBc+wLs2bTFgW+ewxvaLCLRr30RTVWTtM6N8vgFkzn3ynSV+KXxXP
	 GNTERmfYBYQ9YLTvNIzZkXS3Tkumnttne2VGUgGy4yD0VdC3ZQhlasl/Kp89JbbpJR
	 dKotXuo1j+jB9Fbk14Z5Mz84T7ZK6jVo0wUp+wrVdjNMjXzTdc7uSDm8I58yJOq9Wo
	 Igb7CN1mjWxCWzenrVZX7RKmv0gbp0dM/ZoB1GBWyECyjbj1+Ys0VcBt76PnTg7AR9
	 VPFQkJP0TNmxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FF0C40693;
	Mon,  2 Nov 2026 13:10:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 085B3362
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E294F80DEE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:09:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XAdpeqOsCGow for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 08:09:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AAF6480DE7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1131"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793606977;
 b=TdVKtKrosUXDYsmJJTgsjdm0aBNCGQdP/5XFe6IU4pMATz8SMup8iZR1c7saYgLT1jnh
 YNYJv/aIUjCCOWRQHs1H3cWX12Pi4CPtFmdk4WEchdyhIu0zFZ8Rl2hGLBdI4Ec+e5tWK
 aeE30SJHmy+djw9PK+C4hmKq+OszzZe47i1JGBE3QF4wVxAcNtpiADXPdOj+ZVVWq+cY1
 +NiIqQkpddAEhrqCP5D4HltYFuKdN1zbjPe0uhIOf7CFmDVF1dzG/lURGU+jPnpUuJ195
 pz9KQiALKXkknXqQKAAStZrSgzOftNeIFwZSJl9dcwFKmpNIzsVq2xMOVnyALZ0tomw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793606977;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=O9/q1tbEwAJ1Lnd76DAyVKn+aeGH08All/wH/mGAuWc=;
 b=ZIQFzJUFIDpKITzCb+gGG4z65J56Vl3B3DnnmbakOssC9/5h8jzHvom4WwpCjYvX6OhF
 oJOX5Oaphs+shu6TlW3jXVAGDSUrD7nJUKt7cZ6lYBK36cGVBjYGGmVnb1ukyjTmwEinA
 trMYGtsS6U+BhqI5ovhExsqk7SNi1hc52mQQuq24ObRzSTbP0/FV6KANI5uOPYvfQSakP
 JeHeELlPWmrDZkEIzQBbg2NExxaP7Da5/FLFLhWRNMSfILbCetf23YJgtbZcYsYLFb79s
 YhSJYbBuxE0kD2h5gcNO64h4byi8eGm9Eqyv7L+hRUkuJ4IboZvkjtBOnI1t0Plgp3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=xlUp66H5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=nguyenanhgiau1008@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=xlUp66H5
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAF6480DE7
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 08:09:36 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b0db268bd8so16186607b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 00:09:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793606975; cv=none;
 d=google.com; s=arc-20260327;
 b=Uw5MIlnDhk4mWBn+NmEME+cB7mzaMynsGz/Irg3fMIiYlDDP9TThmgFyVPNaGpsPPU
 RGXE6vvN6yYPcvSgwqVQ27kMatB+UcYWalO43WQ2rGGBt8eXfA6repRbPqwtHceHUews
 +cvd2xJ1iPaGCKVZbcvdhhoXpWytV465MoDvcx31pi82mzLsESeuVTtS8ZYSCWRo9Zin
 s9CpFXFAfFT7ogqX7tXC0jpDMyAVfnu3qayu0LpPBLS15qNzFd51cy85GoYhEy/vufYR
 x7h5x9jv1c2Cu+tamIl95Ff8eOnuHyb8Q8mOFxCrO/QeNp8mFDMh8UVscWo0vYo2zThf
 rb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O9/q1tbEwAJ1Lnd76DAyVKn+aeGH08All/wH/mGAuWc=;
 fh=wvv2rEeK4+pj7Liakqf2FbuZVQKqseB/0LiY+tdTmNc=;
 b=MB3yXNKiqtz8hEkTXkVr25MCg1gN+41RBHWSvHttnj2u1Jwko3OMyqlj3IJOkwimIC
 MrDlmgKSWR93f04zfjGHs7NQhfhmnk4jWZPqQA7QdgqZ48Z6dknBZv7LZqArIJ6Sbn3t
 mRw9bEjBKbVqrK3XmZISbMgnL+j4URZe5rsl3715xKYrrwoEd5Mwm66RS2urYpNBEojx
 ST/7sQILjR47huogw2tCUiNX1xotESSVdNCSdbPmEh2F/OF+7Ur0QY64CrqfWfceItrJ
 d8AD5waNqAFAEsRFw1IeK9OlGbVJAGKSu4Ua0hh4njzivgR/cTaNBLAea5Q6grTV9suV
 mH9w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793606975; x=1794211775;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=O9/q1tbEwAJ1Lnd76DAyVKn+aeGH08All/wH/mGAuWc=;
 b=xlUp66H51KP+IQPTLCL8TnQwd3Bq8oM6hrlNif+RijcJjn8I+/3LSyxGOXHJ28SY3I
 BsK6278jU5DwkHT4N0wwtKeqeu+ljdS6FmY+F4QKRE1cJ7Bgd9htER65O0PIdONSGPmr
 mqXO3NM8/PU3XYJTEuHV4lRHf+XkBncA2LeOZz7juUABIshBYAddvzzc++SOg2wcI2BA
 ETTGFJPStJDcAXmC6qt8y0znWBpjYCM0sV4PAIF9StDyrZWf3nvHPOHFcTrnhC1j38DU
 7j3kictMSeKslVeO0yzpg4uNXtIdWxefouGfoTKesxJmAkFCGm0JOdLeZ2SAA4XBKGQ8
 Ix2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793606975; x=1794211775;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O9/q1tbEwAJ1Lnd76DAyVKn+aeGH08All/wH/mGAuWc=;
 b=A4uHhPvaYRY9szI/mjRehaZkz9dyhliiTJpPvuVvdEOEXVpFIJE5s1Zo+rPUYLkefD
 DfkuGQeO4JLTewtfpbLYJvgZPN7f3b9jgkRR5QNT5hyN+OUdr6SJtfJkQ+jcWa0ViouV
 XT6gyn71UvJH78jpOd09WTv4oJ+9S3uRln76y/O7pVE2eB/kKJX90++z3Xv/hFCQwj9b
 VdmBjFucMbzS8uqYSUFXZc+EcwrRgRQ3tm83OIBzwpF8ANwOR2LiKj+KbFuZzo5x2dlm
 kNZYSfWGKJxAk3gWbnspV+gpu9N+4z2XQKeqM6C1p0fUChkwBA00B3Bw00MB/L8fuFuE
 u4+A==
X-Gm-Message-State: APuU4Z+lQDZRMaaVUIgJCuQacGUWm69gFevWuNE7X2O8jCBBja9gx9t6
 SA0hjvV6ilID4LfJmV+JcUadKxcZvutyGA18zXQ//E6ZqLSqbm8a9Vf6JoYz9sx+MBlIbzP7XWb
 TNV60BlzfiHGBy5ZrbWOxi+HM0bLUI38=
X-Gm-Gg: AYBFou3WADi6e3qz8GHVtXvwobqEyXKI5EBaRUgjq+rVVu7+JehDwQD4lPmf7brY76f
 K0613xO8L4dOYDeY3+ugE75lK1HvkTVhPdARi5ETVVW9nrBOC5VU8NFENjZTvJKa3LiuP2guuzQ
 RMfOuX/7ZJQID0DnCZvIvSS9khbZRUSzGYy6V/nVe+f+E7lcrQN7sc2BZzHP45fD0b5gG2g/vQ3
 vFlfN1xoiXhvAGwPSCOechRz7mxk4Kh4xn5swJCTeLcYXBCL0h7hfjEd/iLfsXZAOBwPEq5Aub4
 bAInt58TxLesQ4s6BT9650ShslD3sl3MCHjMHTkpZ0oHYlUjHrOWMPmEiyrw3ls3DcJrdYW2olQ
 kOcU4Ys0tbkNUgjav6i4cIZChrnrKiyw1YBdUo1Z8rTCywm3h5SsyJV0ytG1+MXC9XEFFLzk=
X-Received: by 2002:a05:690e:1309:b0:675:6f49:f5a0 with SMTP id
 956f58d0204a3-67ba5040653mr5313860d50.141.1793606975149; Mon, 02 Nov 2026
 00:09:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028113005.515786-1-nguyenanhgiau1008@gmail.com>
 <CAFLszTjZCFgKzKBTLv-p9YzxeW-0eRoL+S6opcCpZSqbm2sSmw@mail.gmail.com>
In-Reply-To: <CAFLszTjZCFgKzKBTLv-p9YzxeW-0eRoL+S6opcCpZSqbm2sSmw@mail.gmail.com>
From: =?UTF-8?B?R2nDoHUgTmd1eeG7hW4gQW5o?= <nguyenanhgiau1008@gmail.com>
Date: Mon, 2 Nov 2026 15:08:58 +0700
X-Gm-Features: AclHuK_UvYtoaHpJskrZ4v45ce6PDcnvcLDe7-lqpuCLFSBeiw66Nw1y4Jun1WQ
Message-ID: <CAKXvu5grkjrJenVO5d9s0iKByucR+iG6GKrbsoZq_XXGDhMRug@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller
 driver
To: Simon Glass <sjg@chromium.org>, pbrobinson@gmail.com
Cc: u-boot@lists.u-boot-project.org, hs@nabladev.com, mbrugger@suse.com, 
 trini@konsulko.com
Content-Type: multipart/alternative; boundary="0000000000009ed932065f46aa6b"
X-Mailman-Approved-At: Mon, 02 Nov 2026 13:10:33 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000009ed932065f46aa6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Thanks for the in-depth review! Your points make perfect sense, especially
regarding the U-Boot specific polling behavior versus Linux's
interrupt-driven logic.

I will incorporate all your suggestions into the next version:
- Refactoring bcm2835_get_mmc_clock() to avoid duplication.
- Adding the 'depends on ARCH_BCM283X' in Kconfig.
- Dropping the I2C_M_IGNORE_NAK flag and the curr_msg NULL check.
- Using dev_err() instead of printf().
- Removing the redundant set_bus_speed() call in probe().

Hi Peter,

Noted on the threading rule! I will make sure to send the next version as a
fresh, unthreaded post. I will also split the changes into a 2-patch series
(one for the driver, one for the defconfigs) as requested.

I will hold off on sending v4 for a few days to see if there is any further
feedback.

Best regards,
Giau Nguyen
--------------------------------------------------------
Phone: (+84) 387 915 996 <+84%20387%20915%20996>


On Sat, Oct 31, 2026 at 8:59=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:

> Hi Giau,
>
> On 2026-10-28T11:30:05+11:00, Giau Nguyen <nguyenanhgiau1008@gmail.com>
> wrote:
> > i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller driver
> >
> > Mainline U-Boot currently lacks an I2C controller driver for the
> > Broadcom BCM2711 SoC (Raspberry Pi 4).
> >
> > This commit adds a new DM-compliant I2C driver for Broadcom
> > BCM2835/BCM2711 SoCs based on the Linux kernel's i2c-bcm2835.c.
> >
> > The driver dynamically queries the actual VPU core clock rate from
> > the VideoCore firmware via mailbox property messages to calculate
> > the CDIV clock divider, ensuring accurate I2C timing and baud rates
> > on BCM2711.
> >
> > Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.
> >
> > Signed-off-by: Giau Nguyen <nguyenanhgiau1008@gmail.com>
> >
> >  MAINTAINERS                              |   1 +
> >  arch/arm/mach-bcm283x/include/mach/msg.h |   9 +
> >  arch/arm/mach-bcm283x/msg.c              |  22 ++
> >  configs/rpi_4_defconfig                  |   4 +
> >  drivers/i2c/Kconfig                      |  10 +
> >  drivers/i2c/Makefile                     |   1 +
> >  drivers/i2c/i2c-bcm2835.c                | 370
> +++++++++++++++++++++++++++++++
> >  7 files changed, 417 insertions(+)
>
> > diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
> > @@ -116,6 +116,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)
> > +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)
> > +{
> > +     ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rate, msg_clk, 1);
> > +     int ret;
> > +
> > +     BCM2835_MBOX_INIT_HDR(msg_clk);
> > +     BCM2835_MBOX_INIT_TAG(&msg_clk->get_clock_rate, GET_CLOCK_RATE);
> > +     msg_clk->get_clock_rate.body.req.clock_id =3D clock_id;
>
> This duplicates the first half of bcm2835_get_mmc_clock() just above.
> Please can you make bcm2835_get_mmc_clock() call this new function, so
> there is only one copy?
>
> > diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> > @@ -171,6 +171,16 @@ config SYS_I2C_AT91
> > +config SYS_I2C_BCM2835
> > +     bool "BCM2835 I2C controller"
> > +     depends on DM_I2C
>
> The driver uses asm/arch/mbox.h, asm/arch/msg.h and
> bcm2835_get_clock_rate(), so it only builds on bcm283x. Please can you
> add 'depends on ARCH_BCM283X' so it cannot be enabled on other boards?
>
> > diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> > @@ -0,0 +1,370 @@
> > +             if (msgs[i].flags & I2C_M_IGNORE_NAK)
> > +                     ignore_nak =3D true;
>
> I don't think this works as intended. If any one message has the flag,
> NAKs are ignored for the whole transfer. Also, if the NAK comes before
> all the bytes have gone out, the DONE path sets msg_err to
> BCM2835_I2C_S_LEN and you return -EIO anyway. The Linux driver doesn't
> support I2C_M_IGNORE_NAK and I can't find anything in U-Boot that sets
> it for this sort of bus, so I suggest dropping it.
>
> > diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> > @@ -0,0 +1,370 @@
> > +             if (val & BCM2835_I2C_S_DONE) {
> > +                     if (!i2c_dev->curr_msg) {
> > +                             dev_err(dev, "unexpected completion
> status\n");
>
> In Linux this catches an interrupt that arrives when no transfer is
> running. Here we poll inside xfer() with curr_msg always set, so the
> check can never trigger and can be removed.
>
> > diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> > @@ -0,0 +1,370 @@
> > +     priv->regs =3D dev_read_addr_ptr(bus);
> > +     if (!priv->regs) {
> > +             printf("bcm2835_i2c: cannot get base address\n");
> > +             return -EINVAL;
> > +     }
>
> Please use dev_err() here instead of printf(), as you do elsewhere in
> the driver.
>
> > diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c
> > @@ -0,0 +1,370 @@
> > +     bus_clk_rate =3D dev_read_u32_default(bus, "clock-frequency",
> > +                                         I2C_SPEED_STANDARD_RATE);
> > +     ret =3D bcm2835_i2c_set_rate(bus, bus_clk_rate);
> > +     if (ret)
> > +             return ret;
>
> The uclass already does this: i2c_post_probe() reads 'clock-frequency'
> (with the same default) and calls dm_i2c_set_bus_speed(), which calls
> your set_bus_speed() op, so the divider is programmed twice. Please
> can you drop this and keep only the mailbox query and the FIFO/status
> clear in probe?
>
> Regards,
> Simon
>

--0000000000009ed932065f46aa6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Simon,<br><br>Th=
anks for the in-depth review! Your points make perfect sense, especially re=
garding the <span style=3D"border-style:none;background:none"><span style=
=3D"border-style:none;background:none"><span class=3D"Q6ibn ng" style=3D"bo=
rder-style:none;background:none">U-Boot </span></span></span>specific polli=
ng behavior versus Linux&#39;s interrupt-driven logic. <br><br>I will incor=
porate all your suggestions into the next version:<br>- Refactoring bcm2835=
_get_mmc_clock() to avoid duplication.<br>- Adding the &#39;depends on ARCH=
_BCM283X&#39; in Kconfig.<br>- Dropping the I2C_M_IGNORE_NAK flag and the c=
urr_msg NULL check.<br>- Using dev_err() instead of printf().<br>- Removing=
 the redundant set_bus_speed() call in probe().<br><br>Hi Peter,<br><br>Not=
ed on the threading rule! I will make sure to send the next version as a fr=
esh, unthreaded post. I will also split the changes into a 2-patch series (=
one for the driver, one for the defconfigs) as requested.<br><br>I will hol=
d off on sending v4 for a few days to see if there is any further feedback.=
 <br><br>Best regards,<br>Giau Nguyen</div><div><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr"><div>---------------------------------------------------=
-----</div><div>Phone: <a href=3D"tel:+84%20387%20915%20996" value=3D"+8438=
7915996" target=3D"_blank">(+84) 387 915 996</a><br></div></div></div></div=
></div></div></div></div></div></div></div></div><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Oct 31, 2026=
 at 8:59=E2=80=AFPM Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" tar=
get=3D"_blank">sjg@chromium.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Giau,<br>
<br>
On 2026-10-28T11:30:05+11:00, Giau Nguyen &lt;<a href=3D"mailto:nguyenanhgi=
au1008@gmail.com" target=3D"_blank">nguyenanhgiau1008@gmail.com</a>&gt; wro=
te:<br>
&gt; i2c: bcm2835: Add new BCM2835/BCM2711 I2C controller driver<br>
&gt;<br>
&gt; Mainline U-Boot currently lacks an I2C controller driver for the<br>
&gt; Broadcom BCM2711 SoC (Raspberry Pi 4).<br>
&gt;<br>
&gt; This commit adds a new DM-compliant I2C driver for Broadcom<br>
&gt; BCM2835/BCM2711 SoCs based on the Linux kernel&#39;s i2c-bcm2835.c.<br=
>
&gt;<br>
&gt; The driver dynamically queries the actual VPU core clock rate from<br>
&gt; the VideoCore firmware via mailbox property messages to calculate<br>
&gt; the CDIV clock divider, ensuring accurate I2C timing and baud rates<br=
>
&gt; on BCM2711.<br>
&gt;<br>
&gt; Enable CONFIG_SYS_I2C_BCM2835 in rpi_4_defconfig.<br>
&gt;<br>
&gt; Signed-off-by: Giau Nguyen &lt;<a href=3D"mailto:nguyenanhgiau1008@gma=
il.com" target=3D"_blank">nguyenanhgiau1008@gmail.com</a>&gt;<br>
&gt;<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 arch/arm/mach-bcm283x/include/mach/msg.h |=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 arch/arm/mach-bcm283x/msg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 22 ++<br>
&gt;=C2=A0 configs/rpi_4_defconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 drivers/i2c/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 drivers/i2c/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/i2c/i2c-bcm2835.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 370 +++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 7 files changed, 417 insertions(+)<br>
<br>
&gt; diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c=
<br>
&gt; @@ -116,6 +116,28 @@ int bcm2835_get_mmc_clock(u32 clock_id)<br>
&gt; +int bcm2835_get_clock_rate(u32 clock_id, ulong *rate)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ALLOC_CACHE_ALIGN_BUFFER(struct msg_get_clock_rat=
e, msg_clk, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BCM2835_MBOX_INIT_HDR(msg_clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BCM2835_MBOX_INIT_TAG(&amp;msg_clk-&gt;get_clock_=
rate, GET_CLOCK_RATE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0msg_clk-&gt;get_clock_rate.body.req.clock_id =3D =
clock_id;<br>
<br>
This duplicates the first half of bcm2835_get_mmc_clock() just above.<br>
Please can you make bcm2835_get_mmc_clock() call this new function, so<br>
there is only one copy?<br>
<br>
&gt; diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig<br>
&gt; @@ -171,6 +171,16 @@ config SYS_I2C_AT91<br>
&gt; +config SYS_I2C_BCM2835<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool &quot;BCM2835 I2C controller&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on DM_I2C<br>
<br>
The driver uses asm/arch/mbox.h, asm/arch/msg.h and<br>
bcm2835_get_clock_rate(), so it only builds on bcm283x. Please can you<br>
add &#39;depends on ARCH_BCM283X&#39; so it cannot be enabled on other boar=
ds?<br>
<br>
&gt; diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c<br>
&gt; @@ -0,0 +1,370 @@<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (msgs[i].flags &am=
p; I2C_M_IGNORE_NAK)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ignore_nak =3D true;<br>
<br>
I don&#39;t think this works as intended. If any one message has the flag,<=
br>
NAKs are ignored for the whole transfer. Also, if the NAK comes before<br>
all the bytes have gone out, the DONE path sets msg_err to<br>
BCM2835_I2C_S_LEN and you return -EIO anyway. The Linux driver doesn&#39;t<=
br>
support I2C_M_IGNORE_NAK and I can&#39;t find anything in U-Boot that sets<=
br>
it for this sort of bus, so I suggest dropping it.<br>
<br>
&gt; diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c<br>
&gt; @@ -0,0 +1,370 @@<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; BCM2835=
_I2C_S_DONE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (!i2c_dev-&gt;curr_msg) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;unexpected completion=
 status\n&quot;);<br>
<br>
In Linux this catches an interrupt that arrives when no transfer is<br>
running. Here we poll inside xfer() with curr_msg always set, so the<br>
check can never trigger and can be removed.<br>
<br>
&gt; diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c<br>
&gt; @@ -0,0 +1,370 @@<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;regs =3D dev_read_addr_ptr(bus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!priv-&gt;regs) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;bcm2835_=
i2c: cannot get base address\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
Please use dev_err() here instead of printf(), as you do elsewhere in<br>
the driver.<br>
<br>
&gt; diff --git a/drivers/i2c/i2c-bcm2835.c b/drivers/i2c/i2c-bcm2835.c<br>
&gt; @@ -0,0 +1,370 @@<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bus_clk_rate =3D dev_read_u32_default(bus, &quot;=
clock-frequency&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0I2C_SPEED_STANDARD_RATE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D bcm2835_i2c_set_rate(bus, bus_clk_rate);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
<br>
The uclass already does this: i2c_post_probe() reads &#39;clock-frequency&#=
39;<br>
(with the same default) and calls dm_i2c_set_bus_speed(), which calls<br>
your set_bus_speed() op, so the divider is programmed twice. Please<br>
can you drop this and keep only the mailbox query and the FIFO/status<br>
clear in probe?<br>
<br>
Regards,<br>
Simon<br>
</blockquote></div></div>
</div>

--0000000000009ed932065f46aa6b--
