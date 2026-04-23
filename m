Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AABCFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E2E843FB;
	Sat, 25 Apr 2026 19:35:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k4LyHIo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B960584445; Sat, 25 Apr 2026 19:35:49 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C65E184399
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59e4a04f059so10653622e87.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777138547; cv=none;
 d=google.com; s=arc-20240605;
 b=DF4KjtVRGvQyfLEqjOpw4RoCCXS0nRMgAeOiiG/5EOnEI9mXurHK0YgS95R4KVmOrJ
 NUDRIoz6NbaVGgFwaPXZ1vfPsLhm8vWdbbHN00CUh5Vd6Bz30O/eGwZ2M0sCRMYu7xca
 JkYX6gpNFlhr8kaX5cNX9yhXL546FaUKtDpRa2dU3pUNUJLDZ5c+FUrUKwncgJs9/iE2
 0HJNF71G1DQ1YogKXF+ZZQaGKeLKgAY9lfkFof906dxieJ+L15I2PbNpa/mKHzfjKtlx
 PasuJOm2gunvjpgpcnPh3gUYTBQfwinsPj6yBS2Kd4tcRTmMACcUtS6E6oNZggjLckCk
 irDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QlxCPRUBLQQgUlKuwkJ3NqtI5AfH8sEdE/ZLXsc0LyA=;
 fh=LLDkybKv02T/j6bxQlyaN7vjBESbXcFPG0g01MlY+88=;
 b=jW9gwYdVSsSof2DaIwQ3UpRq3+N6niwXVuWwCJON9CTLua0btWwS6PvSikYjw6s16K
 MXorJv6OTPsIqV2HUT2Id10SaYD43J6nRqQhnaO0U9UNlIvyJ466WjyEPtBJXP6XwFOK
 opuo2iVRFUK12oWi1FJZbkaZoKRpP72215yeiCAhFQljaaN2HNH+H8omPOHklAwCEv23
 6HZanTHV2u1xtkwnjtGme/jzfUL8RjRUbcWfs43u4LOa2x7DEXCph8GXDLtt2yt+J1Wm
 lRe8Eaa3Hb3e57wfeTUmlBAoAifbmuCfmeMNUCAkfAJOtIDgjBwmj7q1sawXxFGWp+Oc
 6WEQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777138547; x=1777743347; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlxCPRUBLQQgUlKuwkJ3NqtI5AfH8sEdE/ZLXsc0LyA=;
 b=k4LyHIo8CzOcKPY56K5F05BkDY7GQpIZR2ucU1ZIowNChdhBY6LBWWecTyomagyV5D
 wdRDNQiwIZlX+WN6feBEfwdGVjdtZ75MqLKHHMddOpPInvGCDPO2orz+Ay9atBex1aQc
 muU95Gj4QbaEedFvdajctuJn/Xyxjt/m019GxTRmDPS5LDPVE5GgSlxX+Ff+d+p5A4e4
 mMLpQ0Ai4ZbZ3UxC2jnyYdlVUppVs9T4gp/eBC9od5dd0XZN9RfsVdmjI3883VQbu1mS
 O63M4uXttnJWa3yqxwCp7lCQIfIpTq24XBDBAeGBubTurjtCQjGw1YpENCoCQoAalvpP
 MQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777138547; x=1777743347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QlxCPRUBLQQgUlKuwkJ3NqtI5AfH8sEdE/ZLXsc0LyA=;
 b=F//xipf1Mj8z8QjNg3A/7hUqlJPKNTDBxWa/ykV5LcvqU+CJFVevG+k53WvFUjigEE
 wZLeoivJlExKSS63EhORy82uqAqOFhpuI4B+duLECMu6A6l5LmQ3QefNJ1SS83/MJNYU
 X2C0H24w609DfKfOOGaviyXlot9ToX0RTH1z/AKvYxhilKiALjATPFc/NcG79yQ2reVu
 qLZtzHbqBOJSJPLWx36ihHkmjPl7jmMwaB7jw+XGC1ba2xRpl4zg7vcaq6bL8OxpFvuP
 TUx7GKW41PvZSUixULkKhomg4wKQx1y26Q3kNLlMUnsVfCCZ04R6+piyVxpM7E39t/AH
 4w/Q==
X-Gm-Message-State: AOJu0YzH7Jww0d8oGfsUCYu/oO9sQXeik3OfS8KsQRZ58ntyl3i0b3cH
 zFs9L1oPBXs/gQ2a85Q1w8c7Xi8O7eQcsMoGZ2WMPGRO5eAW9L/jlOXVBl4NJf+QMDt2SuHXC8P
 YtYqHMhoGII0nLteTlRaaBbPa1hJaPLXSRQ==
X-Gm-Gg: AeBDieuXuF+GgSbsIP7kdwyWLzYMWVDWNIeleLpiC0k+9Jm9k5II4qupBSzVq/GiTuK
 R+Kg1tzGln3dkKeYO3azPgyVSoHQ1rA/M8xjo8xO6RbsFdt6s3oxETgPPaITLOg4kIOAT+5QIeI
 PX3TQT8q2r9HU/vl9A+DpQet0yZH8IcBDBlI15Hj1mYTbvbL3U7MCezoeBd5XsCusyZ3r9LNho4
 TdqGPlQV5JCwvgTd+ijz1DAlirGf6l9iyxwAFVCzerxkUXsFEBF6M5Opleo2+QcADjqUoQ+bao7
 fCe19I+Z6/guXtBtwF4Ie6BPE0/cqJhpXomEzB6YgNYICrDf9LzZFKy0jc1+N9P7SA1AYA/+grp
 vdYeBkx9pymfxtIRVqhBmhyyAxkBoKkVjwps6SJQEQKWl+DUDUQJgeTO/t6H8uRUPSQ/gHWE8wP
 xjzh0nsa5Tm9I=
X-Received: by 2002:a05:6402:20c3:20b0:66f:8fbc:c73e with SMTP id
 4fb4d7f45d1cf-672bfd96f56mr10018978a12.9.1776960144618; Thu, 23 Apr 2026
 09:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <LV8PR15MB6416D60889EA3D73880A85688E4FA@LV8PR15MB6416.namprd15.prod.outlook.com>
In-Reply-To: <LV8PR15MB6416D60889EA3D73880A85688E4FA@LV8PR15MB6416.namprd15.prod.outlook.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 23 Apr 2026 17:02:13 +0100
X-Gm-Features: AQROBzC-3fVdsWyCwoMZxuMXXIlBpyP7T7JeC3C4kcQD8mS3CzSnr_1HpjM-_IQ
Message-ID: <CALeDE9MMHawwTju8czhSzE19q6PGnOkxg-zcyXUdrsxY+ZFHcg@mail.gmail.com>
Subject: Re: RFC: Remote signing support for mkimage
To: Daniel Frink <Daniel.Frink@ibm.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 George Wilson <gcwilson@us.ibm.com>, 
 Chris Engel <cjengel@us.ibm.com>, NAYNA JAIN <naynjain@ibm.com>
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

Hi Daniel,

> I wanted to check whether a patch I'd like to submit to mkimage to better=
 support remote secure signing servers would be acceptable for upstream.
>
> Currently, we support this capability via a custom PKCS#11 module via an =
OpenSSL engine. The migration to OpenSSL 3 (and the need to upgrade our lib=
p11 dependency) is going to force major changes on our end, as newer releas=
es of libp11 no longer reliably support signing with our OpenSSL engine/cus=
tom PKCS#11 module. The libp11 maintainers have explicitly stated they only=
 support OpenSSL engines on a best-effort basis.
>
> It seems to me that the ideal solution would be support for a 3-step sign=
ing flow in mkimage:
>
> 1. mkimage --emit-hashes =E2=80=94 emits all hashes that need to be signe=
d
> 2. External signing tooling produces signatures
> 3. mkimage --inject-signatures =E2=80=94 signatures for each hash are pro=
vided, validated against a provided public key, and injected back into the =
image
>
> We're aware the OpenSSL provider system is a potential uplift path, but w=
e believe a tooling-agnostic signing interface would be more accessible to =
organizations with diverse signing infrastructure, avoiding the need to imp=
lement and maintain custom OpenSSL plugin code entirely. We'd also prefer n=
ot to resort to workarounds such as signing with a throwaway key and manual=
ly extracting/re-injecting signatures.
>
> If this direction seems acceptable, or if you're open to the idea but hav=
e concerns about the approach, I'd welcome your feedback before investing t=
ime in a full patch.

I think the ability to do remote signing functionality would be fine.
It might be useful to go into a bit more details of what you're
thinking here, is there open standards/APIs for this sort of
integration? Most of what I'm aware of, and it's been some time since
I looked, was either using PKCS interfaces or proprietary
APIs/libraries, the later IMO would not be appropriate.

Regards,
Peter
