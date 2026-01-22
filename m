Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF06D6CFC5
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 04:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF72839DF;
	Fri, 23 Jan 2026 05:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mm2ewxSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A732D839DF; Fri, 23 Jan 2026 00:59:00 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B40383946
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 00:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so1089473f8f.0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 15:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769126337; x=1769731137; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hfzci/6maJ3a5urWpJI9GfFUMwWwFuxrNN5LuWZf0zc=;
 b=mm2ewxSa6UPNBFlKjF5KShAgKAhajQGSxeAAHR7koVS8lcvij7voz1hZdK9t2TGXIF
 m8LuPrwXfxdn4UqYmGZRqiJh4pitDAj1kaJLa3O4x2gDNUlntAHqfoeVR3ygTkSwcw03
 5K2q/CFMWNHJYC9/R3oMeMmXSM55RSLNloHp5oCvYZ9JDLMcv7pZJ2xFZFIcAV+XLCjf
 5RKvhhURta9XepaIUxw0ygB5UYs3ap+4/C7UZIkke/KjNA6QHBeA9zzx2tu1yE5FMong
 oeEZxvT02NswIA6D1QIRmbT1uFztEKcRXjaESyj8lWn60dUm/hM53+9vTpgJvgB/sroL
 yjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769126337; x=1769731137;
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hfzci/6maJ3a5urWpJI9GfFUMwWwFuxrNN5LuWZf0zc=;
 b=DmUXuxhDL8N69dMzpxCA8/skEZ3NjRecYiVVjvaeLj/mO9cs6GGVyj5hCfuzTo2tGY
 SrUcYZoXg07DwCeL2ZuQHJgsZxz0elljlkrnKBQCz7LsGifW8gZkVQk37h7qIrrvUorK
 HJOrdpZ68tG827jc1IyaV8SaBhJtayQ+gTd3u9Jq33NQuPpe95kRGB+mb9LeNUV900oy
 KRxjIT2TSXhU573dllM0DyMnH2yQKSsZ89KNw+pPngsQ/PC7+pSB6cWTSgbkvk/yYKdn
 3/FYSo+8uXVCKbz+aOsCXM6Hu44sk+/nOpZ3NJ1DjS9x8x27c0qm77ljoi84eQ4b7aBh
 JNfg==
X-Gm-Message-State: AOJu0YwkWY8081PgvX00HbD9zTQI0TgrXJADn8yfNzCvbKR7QP8xhqEw
 y5PUTQYSYK4bq26M0EI8YufToYaU2CxP/ukrnKuDZQT+In0XQZmhADQUHLJVGg==
X-Gm-Gg: AZuq6aLvzI0eqnQmxM7hh5HlrEzuCLN66c6eCSMPl86TBRGCohCMrPh9Q12smykA6Qn
 GX6mUHxmkIwsUBNX7K6cqQwFD7VEuJUqL0zQs6iwhsue+bQxFxIaG2nMd8I7WpFsTD9idh9W/Za
 4gjVV3+D3RdoyD9tRg3phOePSRj+FGuhuCd3AYNxar5qX9CwCHyw5abf3J7T1mK7dvgr+Qt4EsQ
 IAaJsbnKEhWGEp1zrTMOj60cF1jcHd6D1w2lhv4toIbq+A4dklHSBgIOUOo91189Y9h/Mc9cZ4r
 AFDBtPf/3KqTNsdWCLIuJSBNyUF5YEsK/op44QGHDUmDj49TAMM46c/QYnOviLJxBZVTXNIGpda
 GN3OiBinh891TZ6IrRDj5r5Eu3NBUA4RZXKQtJOHaj3Tcl7JJy0BZbarC6FoVlSqTSuGk2Bbfe5
 K5GKekxALXwnYwyUI/EkMkNCjEAYRMxRElWA==
X-Received: by 2002:a05:6000:4026:b0:435:9cd5:bb2e with SMTP id
 ffacd0b85a97d-435b159124bmr2279888f8f.11.1769126337407; 
 Thu, 22 Jan 2026 15:58:57 -0800 (PST)
Received: from vitor-nb.Home (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24ac1sm2202435f8f.14.2026.01.22.15.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 15:58:56 -0800 (PST)
Message-ID: <d7d22e35540857e9726f4b435a73a1435aa4fe37.camel@gmail.com>
Subject: Toradex Verdin AM62 boot failure on recent master
From: Vitor Soares <ivitro@gmail.com>
To: u-boot@lists.denx.de
Cc: vitor.soares@toradex.com, trini@konsulko.com, n-francis@ti.com, 
 b-padhi@ti.com, afd@ti.com, anshuld@ti.com
Date: Thu, 22 Jan 2026 23:58:54 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 23 Jan 2026 05:36:15 +0100
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


Hi,

I'm experiencing a boot failure on Toradex Verdin AM62 with the latest mast=
er.
The last known good commit is a4dc1c3b7d56 and it fails to boot at 64662b99=
c0eb
(current HEAD).

Looking at the 35 commits in this range, I noticed that the first commit af=
ter
my last known good is 85f586035d75 ("ARM: OMAP2+: Pad SPL binary to 8-byte
alignment before DTB"), which directly modifies the K3/AM62 SPL linker scri=
pt.

Related commits:
  85f586035d75 ARM: OMAP2+: Pad SPL binary to 8-byte alignment before DTB
  8b0ebe054bb3 arm: Update linker scripts to ensure appended device tree is
aligned

Could these changes be related to the boot failure? Any insights would
be appreciated.

Thanks,
Vitor Soares

