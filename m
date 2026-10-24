Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B45606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Sk7c1oJ3;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RnFEBfK0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75E0E81692;
	Sat, 24 Oct 2026 10:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3faIM64tJQg; Sat, 24 Oct 2026 10:12:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A4C08166C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836767;
	b=rSOzcIVgD1/ggq3i3qOS+bLW8qdhxOm+ukkxuzHoYTXxhHnAtKxwUvyyRrqi6lOqsPW4
	 lQ+XCXN0bS1VtxTobu+yIkxLywZ0xKDGKEuoAatNWIvLxRlB9syquh5j+0H1PU3zDj+M9
	 fcbtUumhD5zQl9Dtb5x2r2z35f1hz8Ohbfq26Kq58jq+Jyj0rf+U2FVO7QvP59rS9pmED
	 0hW/vUxPhVYH0UUg/aXFFy3KtCwpEw6BhwOoEWVP4q+qdmEoP0emdznrGU5SNiTjL2IG3
	 VidCQEP0bzqzXCZpLj0BlUh80jD1M26u2eS15GrSyrIJuOFTRIhE0c58YdlwkwdDdGw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792836767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=owVI53MoR9URos1jNDzubp/epxxuqQpDK7cIUnUZyCc=;
	b=owhHLmvnwltuQTWEqTdBBoLmns3y26dYvmRjFX30zsp4YV/ACvoOxgD+deYU/NKuTD4v
	 b1AQpGQxrzlaEhJvVsLbpSc0Ur5CnBHmJBkhF5IkwAbEAprzP6YXcWkAuZVIp1dwx5qYr
	 VOzAyJKVo0VULN/82VA2fZo0elZL1Q1MlAlD0nPh3j+V3ATcA5ogHEOelUvw/ocgDV08g
	 TpOJ0maYtUaqVg10YUyK7XNPDDJLQndm4SlKxT85iVkkig05Nby9w+9Vz6AaJj0ecwhsO
	 EAPEmLqNoo6UTOXjbajhOcAe9WXgh/X4u0vQQ5J4E4x0jfvDkNQboTqvOxPNSOZ5zJQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RnFEBfK0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792836767;
	bh=owVI53MoR9URos1jNDzubp/epxxuqQpDK7cIUnUZyCc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sk7c1oJ34rAMzVoCnkgE+ABqg3/z55NJIPKonHAVoo8t3ZX366TwfxKPhX/n7NnJm
	 PULLf0rg/bER9ts809/1o5tDqpxuPSjNTeFL1N+RiZLfSZIrrHdrF94MC6CrZJfyuO
	 xrhcIDPSrP/TqeKw14cyMKQEx/D7YqZd6eQxeFhyO2hibTWXsFrDlyqwzpgkJ3sC3c
	 pT3x26EoB+gbcaF6SQAAs7rszqzlqaRhiy4vsS+SlOt6aUF9cc/K3VX/RVdIJlLqr5
	 g7MNd0U5rredxz5+60hPzWOgTMCYDLcpHyTClyDjfjHSx6v7ZOCoKURcL1GuRF2rVR
	 yhSaz3v94+kEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A4C08166C;
	Sat, 24 Oct 2026 10:12:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1971543
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B30B8168F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6WwiSfeFbyY for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 10:12:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0CB1081687
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::36"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836765;
 b=mpMakBzQ4d08n1Fxw1nRjodl9QYumLvPD8z5Q7qOQpNTGjMsQolQrigl3BMzZB3V4yUb
 LfAvwZaP5TbVJu2UiVBomch7hVa1jZsYvV3oZlJ5a7PNyUBcEQl4mdRpUhZ8w9OXT7GY4
 5iMkb0yc0iOwlfjbz0cfmfxCHW9GvW797j6kwHvE0R2GafvC4izNNh7rpPZT9HRhlwzGD
 0uYNpvYYKI9BHN75bKJri7tB2H5wpuAaedl5MQT9HMWPsNN36w60C573qoOiiq0hlWVWP
 6WWUacWffAc5T3jzXLD8B43AyMAoR7A7rLvgoUoCvGixhUog/whtKSRuSKdD3tmb07w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792836765;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=owVI53MoR9URos1jNDzubp/epxxuqQpDK7cIUnUZyCc=;
 b=j0xhzQB9+SPUo8PwIwkGiA8f32oqON58FsSLh3q7l4uNOWdNhrAUXlZkLDk7D+hUK3t5
 Lf5iH09niEID9FvBS/4gT+Jqlt9dKn44I+aAbQqBWjPIXmE26WITTAzTwMMaw8Elq7ILX
 JEunlw5cvRygJehFTNBXE4VAeMkG0tjyT3B3wOfUY2Tk1TVD+N0E+OdOTpdBvDUGZT71f
 H9u3fYc6ebUy79HUedsx4eVccVQlx1qgn99s7d/wI6omls8YnDxVZ7TCBDQP/etw/96hX
 CGRARB36A7fwwIsh4e/BwLqZtl6RYuHCSI4PGlnN/1TMo7IcXumhbb9oVyuNy0WvICw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RnFEBfK0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RnFEBfK0
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0CB1081687
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:44 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-475920b9ca2so621451fac.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 03:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792836763; cv=none;
 d=google.com; s=arc-20260327;
 b=CqIoG+StIsSTLzPdHPE5botqs9ce1J2V/i3f7iqc86hKdat1NAELAuuJjO1YRTaSYO
 gJd2cGH7JrLbS45dMJJWPfhBnghO1uyNpxD31Q84bFWKOoUKnvW3XYVBOlH24TSTlu6V
 G7DAFxyY7195x4tgZg8117yY3f2Di6bAXRjIWLLXpH1cA7CraaaSSYh7dVWqyf7ytYbP
 8Ugs+NTclC2r4jRqTHL87jppTZjglPh/B2Q5d1rLjtSR0e36ygqNF0Crrhk9/MlnlCPF
 Y+Z8vG92ywD6yBzwoHVZ4UPSH5apnInDMxnIP/zUyDBZdjQBKW2FUz/BEB4xsO8q9yfT
 F/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=owVI53MoR9URos1jNDzubp/epxxuqQpDK7cIUnUZyCc=;
 fh=Y1ZREHJ+pHB0HlzZ/KBn18KcwK0OUTCLdCrezQyH/Kw=;
 b=B0DaJyAWGgc1rgxeZpIqS71vgEnjg4PDJnJkwpQ8ctnlTNZyzdUTyokVMEh0Isj2Hk
 Fs99qj5e2XV6bhbL3LSm+aoNiDP8NplEjmShr1RIzplx+lSG4TXQ/CstdxBmk/awoBTO
 78CqPYVyldAJCqJWazV82ExZfmScR+Gti5G6xcAi1SrtC0dzgBpejGT9mqX8ItDP4qba
 UY2GqRo9jOq7t2b1JJny4PliJ9RY81qhebNNEYfrd1/L5Zpck/e5wxL2uZLaWUXZASdJ
 6B+39AehoN02RctlORjd/MAVGB1hfC905bAZA6iJK3lt+vxF1hTw3gCIyuQxVVJusPaM
 pMxw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792836763; x=1793441563;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=owVI53MoR9URos1jNDzubp/epxxuqQpDK7cIUnUZyCc=;
 b=RnFEBfK00DjxP9cNSIgG/zbai2syKqrGdIQpsYU4gx3ktQ1c3cH4Ftx3RlxerpqpeT
 4GHyNDE/hjNo2pABEU3J/+AHNWLsZm7S3lls7OYBHFwrBSaKD1AWzSFlb/9I+inPKhzb
 Mn9wYp1h4uzgvFV8lsm3X24qVDjrDmzZ/aUcqRFjIkR8rNAfRLkrLHR+fWNK1sxw9Whk
 zBm160WawcsM1O6Q0ubHNYiM9wMdlcomhDu6626WDc0FE7dSc1zSWG1X3snCexMnbQjx
 FAquxG66lvDxDZbXpflXVstNjiETHzYAJ6rHfeUroBmsgDfSRVjcXfSsTI/Li855j351
 a7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792836763; x=1793441563;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=owVI53MoR9URos1jNDzubp/epxxuqQpDK7cIUnUZyCc=;
 b=ftURCiZqU7sPlZaplHIsz7/du0Xvdnexkai5TqCWRsL8wOog8x3qQT0FqruC0vBY53
 1pV9t0TMsOR24TEEr/ngvjuwbxel04bpYeHDQbM/kJN0NjyP9LojktATPQbagUsk8vCc
 JyLnPpzw9nKNE1u00zXAfTN/DO3+/eqAxdTLb7S0JShUh8HWS30X923EYLeV20uUXIwC
 BLAb95v0uusXtrSlHxOMlKbHFSW/R+O7ASMZRDs0c2CGEwkRoLc/W2XChTyM8eAES3Bf
 Y+CWJ62Ccc2FqrqxoVs3Dw4uTEdIx9HTB10t5uwzlhxeWptOxuDu0ZQ+tlkSmm4cpvk6
 MLag==
X-Gm-Message-State: AFq9FYJKqpxqmYZNRF5xpah+GmalC2Bw2+MJi0RtNcDweC3f8Go5NMeX
 SyVFsATWKsNUbTF+G8Z+dywt8TWEWtXB/gV1lJ0FwOEBQt8v0RtBzvUdqIeTxKMM+rlO2mxUMKM
 th0ziqNSTaEpt++wBy+/zTPu0GXCF8XlF4RI9
X-Gm-Gg: AYBFou0CvlmHauv1Upyz/t8OyGfSBdoc781pSSFs22PSSJ7l4peZMyx9Lf0Z9O9m/2N
 V+i/ABfCVZIwTpugaosugs3AThCbJP3MdjN4dDJ0hb2Tu5PiCiZ11xuYQINQEiZ97g/OdMmcuBt
 oBENmsgQE3geVpws1DisEKCB84OBGl0IZ/O6CA3r9Nf7BgspL+SJoNT0/a4YQ4m5jmFaY+BQ2nL
 mOtzRxsbwpn9wUE4gzPJldduarg4EfWB9UnTGq9/kqeqwUKdNDo9PdjzL9W8HqlvqRg3QIjMvIE
 4lmx6rsMHNSjeg1LuKzTd+FMgp+Pns7X3gXqoQ2SLnFfPO0mRrE82qS+HZMVLbws1TyQzsclkhJ
 TS0Gl449VlXrOIpjKHYMRm+c3bSjlaz/56dThAg==
X-Received: by 2002:a05:6808:11c7:b0:4f5:4ce8:7e92 with SMTP id
 5614622812f47-55c002d9d8cmr1000196b6e.48.1792836763314; Sat, 24 Oct 2026
 03:12:43 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:40 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:40 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
References: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 03:12:40 -0700
X-Gm-Features: AclHuK8OzxN8M7In0HHS0WPC0thE3FLpZczXkWei5t_8LViSIhKvRTldV6DaZv4
Message-ID: <CAJnxHsjhMMY+Xjb+B7dDB5+q-s3Rsfr54FAoMPpTLiBNjsD82w@mail.gmail.com>
Subject: [PATCH 2/9] usb: storage: Refuse a block size the block layer cannot
 use
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, 
 Javier Martinez Canillas <javierm@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000006b2691065e9356a3"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000006b2691065e9356a3
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--0000000000006b2691065e9356a3
Content-Type: text/plain; charset="utf-8"; name="0002.patch"
Content-Disposition: attachment; filename="0002.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: c9408c650a43716e_0.1

dXNiX3N0b3JfZ2V0X2luZm8oKSB0YWtlcyB0aGUgYmxvY2sgc2l6ZSBmcm9tIHRoZSBSRUFEIENB
UEFDSVRZIHJlcGx5IG9mCnRoZSBkZXZpY2UgYXMgaXQgaXMuIFdpdGggdGhlIGJsb2NrIGxheWVy
IG5vdyByZWZ1c2luZyBhbiB1bnN1cHBvcnRlZApibG9jayBzaXplLCBzdWNoIGEgZGV2aWNlIHdv
dWxkIGZhaWwgdG8gcHJvYmUgaW4gYmxrX3Bvc3RfcHJvYmUoKSwgYW5kCnVzYl9zdG9yX3Byb2Jl
X2RldmljZSgpIHdvdWxkIHN0b3AgdGhlcmUsIHNraXBwaW5nIHRoZSBvdGhlciBMVU5zIG9mIHRo
ZQpkZXZpY2UuCgpDaGVjayB0aGUgYmxvY2sgc2l6ZSB3aGVyZSBpdCBpcyByZWFkLCBhbmQgdHJl
YXQgYSBMVU4gcmVwb3J0aW5nIG9uZQp0aGF0IGJsa192YWxpZF9ibGtzeigpIHJlamVjdHMgYXMg
dW51c2FibGUsIGFzIGZvciBhIExVTiB0aGF0IGlzIG5vdApyZWFkeS4gVGhpcyBhbHNvIGNvdmVy
cyB0aGUgbGVnYWN5IChub24tQkxLKSBwYXRoLCB3aGljaCBjYWxscwpwYXJ0X2luaXQoKSBpdHNl
bGYuCgpUaGUgZmFsbGJhY2sgdXNlZCB3aGVuIFJFQUQgQ0FQQUNJVFkgZmFpbHMgc2V0cyB0aGUg
cmVwbHkgaW4gaG9zdCBieXRlCm9yZGVyLCB3aGlsZSBpdCBpcyByZWFkIGJhY2sgYXMgYmlnIGVu
ZGlhbiwgc28gb24gYSBsaXR0bGUtZW5kaWFuIGhvc3QKdGhlIGRldmljZSBnb3QgYSBibG9jayBz
aXplIG9mIDEyOEtpQiByYXRoZXIgdGhhbiA1MTIgYnl0ZXMuIFNldCBpdCBpbgpiaWcgZW5kaWFu
IGxpa2UgdGhlIHJlcGx5IGl0IHN0YW5kcyBpbiBmb3IuCgpBZGQgYSB0ZXN0IHdoZXJlIHRoZSBz
YW5kYm94IGZsYXNoIHN0aWNrIHJlcG9ydHMgYW4gdW5zdXBwb3J0ZWQgYmxvY2sKc2l6ZS4KClNp
Z25lZC1vZmYtYnk6IEFuYSBCb2JpbGxvIDxhbmFib2JpbGxvM0BnbWFpbC5jb20+Ci0tLQogYXJj
aC9zYW5kYm94L2luY2x1ZGUvYXNtL3Rlc3QuaCAgfCAxMCArKysrKysrCiBjb21tb24vdXNiX3N0
b3JhZ2UuYyAgICAgICAgICAgICB8ICA4ICsrKystLQogZHJpdmVycy91c2IvZW11bC9zYW5kYm94
X2ZsYXNoLmMgfCAgOCArKysrKysKIHRlc3QvZG0vdXNiLmMgICAgICAgICAgICAgICAgICAgIHwg
NDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgNjkg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3NhbmRib3gv
aW5jbHVkZS9hc20vdGVzdC5oIGIvYXJjaC9zYW5kYm94L2luY2x1ZGUvYXNtL3Rlc3QuaAppbmRl
eCAwNDM4NzkwMDI4Yi4uZTU1OTBkMDFhOTIgMTAwNjQ0Ci0tLSBhL2FyY2gvc2FuZGJveC9pbmNs
dWRlL2FzbS90ZXN0LmgKKysrIGIvYXJjaC9zYW5kYm94L2luY2x1ZGUvYXNtL3Rlc3QuaApAQCAt
MTIzLDYgKzEyMywxNiBAQCBsb25nIHNhbmRib3hfaTJjX3J0Y19nZXRfc2V0X2Jhc2VfdGltZShz
dHJ1Y3QgdWRldmljZSAqZGV2LCBsb25nIGJhc2VfdGltZSk7CiAKIGludCBzYW5kYm94X3VzYl9r
ZXliX2FkZF9zdHJpbmcoc3RydWN0IHVkZXZpY2UgKmRldiwgY29uc3QgY2hhciAqc3RyKTsKIAor
LyoqCisgKiBzYW5kYm94X2ZsYXNoX3NldF9ibG9ja19zaXplKCkgLSBTZXQgdGhlIGJsb2NrIHNp
emUgYSBmbGFzaCBzdGljayByZXBvcnRzCisgKgorICogQGRldjoJVVNCIGZsYXNoLXN0aWNrIGVt
dWxhdG9yCisgKiBAYmxvY2tfc2l6ZToJQmxvY2sgc2l6ZSBpbiBieXRlcworICoKKyAqIFRoZSBo
b3N0IHJlYWRzIGl0IHdoZW4gaXQgbmV4dCBwcm9iZXMgdGhlIHN0aWNrJ3MgbWFzcy1zdG9yYWdl
IGRldmljZS4KKyAqLwordm9pZCBzYW5kYm94X2ZsYXNoX3NldF9ibG9ja19zaXplKHN0cnVjdCB1
ZGV2aWNlICpkZXYsIGludCBibG9ja19zaXplKTsKKwogLyoqCiAgKiBzYW5kYm94X29zZF9nZXRf
bWVtKCkgLSBnZXQgdGhlIGludGVybmFsIG1lbW9yeSBvZiBhIHNhbmRib3ggT1NECiAgKgpkaWZm
IC0tZ2l0IGEvY29tbW9uL3VzYl9zdG9yYWdlLmMgYi9jb21tb24vdXNiX3N0b3JhZ2UuYwppbmRl
eCBhYzMzMWYxYzFiMC4uNDlhY2FlMjY3MjQgMTAwNjQ0Ci0tLSBhL2NvbW1vbi91c2Jfc3RvcmFn
ZS5jCisrKyBiL2NvbW1vbi91c2Jfc3RvcmFnZS5jCkBAIC0xNDk2LDggKzE0OTYsOCBAQCBpbnQg
dXNiX3N0b3JfZ2V0X2luZm8oc3RydWN0IHVzYl9kZXZpY2UgKmRldiwgc3RydWN0IHVzX2RhdGEg
KnNzLAogCWlmICh1c2JfcmVhZF9jYXBhY2l0eShwY2NiLCBzcykgIT0gMCkgewogCQlwcmludGYo
IlJFQURfQ0FQIEVSUk9SXG4iKTsKIAkJc3MtPmZsYWdzICY9IH5VU0JfUkVBRFk7Ci0JCWNhcFsw
XSA9IDI4ODA7Ci0JCWNhcFsxXSA9IDB4MjAwOworCQljYXBbMF0gPSBjcHVfdG9fYmUzMigyODgw
KTsKKwkJY2FwWzFdID0gY3B1X3RvX2JlMzIoMHgyMDApOwogCX0KIAlkZWJ1ZygiUmVhZCBDYXBh
Y2l0eSByZXR1cm5zOiAweCUwOHgsIDB4JTA4eFxuIiwgY2FwWzBdLCBjYXBbMV0pOwogI2lmIDAK
QEAgLTE1MTIsNiArMTUxMiwxMCBAQCBpbnQgdXNiX3N0b3JfZ2V0X2luZm8oc3RydWN0IHVzYl9k
ZXZpY2UgKmRldiwgc3RydWN0IHVzX2RhdGEgKnNzLAogCWJsa3N6ID0gYmUzMl90b19jcHUoY2Fw
WzFdKTsKIAogCWRlYnVnKCJDYXBhY2l0eSA9IDB4JTA4eCwgYmxvY2tzeiA9IDB4JTA4eFxuIiwg
Y2FwYWNpdHksIGJsa3N6KTsKKwlpZiAoIWJsa192YWxpZF9ibGtzeihibGtzeikpIHsKKwkJcHJp
bnRmKCJVbnN1cHBvcnRlZCBibG9jayBzaXplICV1XG4iLCBibGtzeik7CisJCXJldHVybiAwOwor
CX0KIAlkZXZfZGVzYy0+bGJhID0gY2FwYWNpdHk7CiAJZGV2X2Rlc2MtPmJsa3N6ID0gYmxrc3o7
CiAJZGV2X2Rlc2MtPmxvZzJibGtzeiA9IExPRzIoZGV2X2Rlc2MtPmJsa3N6KTsKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2VtdWwvc2FuZGJveF9mbGFzaC5jIGIvZHJpdmVycy91c2IvZW11bC9z
YW5kYm94X2ZsYXNoLmMKaW5kZXggYjUxNzZiYjMwY2UuLjAyZTA5MDEwNTBmIDEwMDY0NAotLS0g
YS9kcml2ZXJzL3VzYi9lbXVsL3NhbmRib3hfZmxhc2guYworKysgYi9kcml2ZXJzL3VzYi9lbXVs
L3NhbmRib3hfZmxhc2guYwpAQCAtMTMsNiArMTMsNyBAQAogI2luY2x1ZGUgPHNjc2kuaD4KICNp
bmNsdWRlIDxzY3NpX2VtdWwuaD4KICNpbmNsdWRlIDx1c2IuaD4KKyNpbmNsdWRlIDxhc20vdGVz
dC5oPgogCiAvKgogICogVGhpcyBkcml2ZXIgZW11bGF0ZXMgYSBmbGFzaCBzdGljayB1c2luZyB0
aGUgVUZJIGNvbW1hbmQgc3BlY2lmaWNhdGlvbiBhbmQKQEAgLTM1Nyw2ICszNTgsMTMgQEAgc3Rh
dGljIGludCBzYW5kYm94X2ZsYXNoX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpCiAJcmV0dXJu
IDA7CiB9CiAKK3ZvaWQgc2FuZGJveF9mbGFzaF9zZXRfYmxvY2tfc2l6ZShzdHJ1Y3QgdWRldmlj
ZSAqZGV2LCBpbnQgYmxvY2tfc2l6ZSkKK3sKKwlzdHJ1Y3Qgc2FuZGJveF9mbGFzaF9wcml2ICpw
cml2ID0gZGV2X2dldF9wcml2KGRldik7CisKKwlwcml2LT5lbWluZm8uYmxvY2tfc2l6ZSA9IGJs
b2NrX3NpemU7Cit9CisKIHN0YXRpYyBpbnQgc2FuZGJveF9mbGFzaF9yZW1vdmUoc3RydWN0IHVk
ZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3Qgc2FuZGJveF9mbGFzaF9wcml2ICpwcml2ID0gZGV2X2dl
dF9wcml2KGRldik7CmRpZmYgLS1naXQgYS90ZXN0L2RtL3VzYi5jIGIvdGVzdC9kbS91c2IuYwpp
bmRleCBmYTg5NGMxMDk2ZS4uYzUzZTZjNDhmZjAgMTAwNjQ0Ci0tLSBhL3Rlc3QvZG0vdXNiLmMK
KysrIGIvdGVzdC9kbS91c2IuYwpAQCAtODQsNiArODQsNTEgQEAgc3RhdGljIGludCBkbV90ZXN0
X3VzYl9mbGFzaChzdHJ1Y3QgdW5pdF90ZXN0X3N0YXRlICp1dHMpCiB9CiBETV9URVNUKGRtX3Rl
c3RfdXNiX2ZsYXNoLCBVVEZfU0NBTl9QREFUQSB8IFVURl9TQ0FOX0ZEVCk7CiAKKy8qIFRlc3Qg
dGhhdCBhIGZsYXNoIHN0aWNrIHJlcG9ydGluZyBhbiB1bnN1cHBvcnRlZCBibG9jayBzaXplIGlz
IHJlZnVzZWQgKi8KK3N0YXRpYyBpbnQgZG1fdGVzdF91c2JfZmxhc2hfYmxrc3ooc3RydWN0IHVu
aXRfdGVzdF9zdGF0ZSAqdXRzKQoreworCXN0YXRpYyBjb25zdCBzdHJ1Y3QgeworCQlpbnQgYmxr
c3o7CisJCWJvb2wgb2s7CisJfSBjYXNlc1tdID0geworCQl7IDI1NiwgZmFsc2UgfSwKKwkJeyA1
MjAsIGZhbHNlIH0sCisJCXsgMiAqIEJMS19NQVhfQkxLU1osIGZhbHNlIH0sCisJCXsgU1pfNEss
IHRydWUgfSwKKwl9OworCXN0cnVjdCB1ZGV2aWNlICpkZXYsICplbXVsLCAqYmxrOworCXN0cnVj
dCBibGtfZGVzYyAqZGVzYzsKKwlpbnQgaSwgcmV0OworCisJc3RhdGVfc2V0X3NraXBfZGVsYXlz
KHRydWUpOworCXV0X2Fzc2VydG9rKHVzYl9pbml0KCkpOworCXV0X2Fzc2VydG9rKHVjbGFzc19n
ZXRfZGV2aWNlKFVDTEFTU19NQVNTX1NUT1JBR0UsIDAsICZkZXYpKTsKKwl1dF9hc3NlcnRvayh1
Y2xhc3NfZ2V0X2RldmljZV9ieV9uYW1lKFVDTEFTU19VU0JfRU1VTCwgImZsYXNoLXN0aWNrQDAi
LAorCQkJCQkgICAgICAmZW11bCkpOworCisJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoY2Fz
ZXMpOyBpKyspIHsKKwkJLyogUHJvYmUgdGhlIHN0aWNrIGFnYWluLCBzbyB0aGF0IGl0IHJlYWRz
IHRoZSBibG9jayBzaXplICovCisJCXNhbmRib3hfZmxhc2hfc2V0X2Jsb2NrX3NpemUoZW11bCwg
Y2FzZXNbaV0uYmxrc3opOworCQl1dF9hc3NlcnRvayhkZXZpY2VfcmVtb3ZlKGRldiwgRE1fUkVN
T1ZFX05PUk1BTCkpOworCQl1dF9hc3NlcnRvayhkZXZpY2VfY2hsZF91bmJpbmQoZGV2LCBOVUxM
KSk7CisJCXV0X2Fzc2VydG9rKGRldmljZV9wcm9iZShkZXYpKTsKKworCQlyZXQgPSBkZXZpY2Vf
ZmluZF9maXJzdF9jaGlsZF9ieV91Y2xhc3MoZGV2LCBVQ0xBU1NfQkxLLCAmYmxrKTsKKwkJaWYg
KCFjYXNlc1tpXS5vaykgeworCQkJdXRfYXNzZXJ0ZXEoLUVOT0RFViwgcmV0KTsKKwkJCWNvbnRp
bnVlOworCQl9CisJCXV0X2Fzc2VydG9rKHJldCk7CisJCWRlc2MgPSBkZXZfZ2V0X3VjbGFzc19w
bGF0KGJsayk7CisJCXV0X2Fzc2VydGVxKGNhc2VzW2ldLmJsa3N6LCBkZXNjLT5ibGtzeik7CisJ
fQorCisJdXRfYXNzZXJ0b2sodXNiX3N0b3AoKSk7CisKKwlyZXR1cm4gMDsKK30KK0RNX1RFU1Qo
ZG1fdGVzdF91c2JfZmxhc2hfYmxrc3osIFVURl9TQ0FOX1BEQVRBIHwgVVRGX1NDQU5fRkRUKTsK
KwogLyogdGVzdCB0aGF0IHdlIGNhbiBoYW5kbGUgbXVsdGlwbGUgc3RvcmFnZSBkZXZpY2VzICov
CiBzdGF0aWMgaW50IGRtX3Rlc3RfdXNiX211bHRpKHN0cnVjdCB1bml0X3Rlc3Rfc3RhdGUgKnV0
cykKIHsK
--0000000000006b2691065e9356a3--
