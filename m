Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F90606A31E
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IK0F1aSn;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pB32TEoo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24EC560628;
	Sun, 15 Nov 2026 13:11:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2xgPzBJjNlZ; Sun, 15 Nov 2026 13:11:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A2E76062B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794748287;
	b=AhtaWTKYfoJ7ImuNio/kVKGfKLUBAe15mwyznQ14WIPUPVM2mSzEwDUQ2Mwitd/qVpLa
	 KZRH2J/yi5hY3MKZsOKC87YwE9+MvLnsSSSQmihsMDOL+tEJ4hw5RTTbKh1saDI/5632y
	 QN+tOGI4BfJhEuj+vHpek/8X+YsEjOYWuuNNv/F5Js8gHbDaU6VsTm888FYfjbJxazQI7
	 laEF9LxIp+iJK9czMXphEU2g897ivJ7HZ2QloT1QCCA+3pntamaKIEIOyK0fcFoBICXyW
	 Uv7YQsXPJ0z0lUG0Y4v0PkStxyN90spHx7BIksVwBd3UoIhiQlzuSoDbf2bplXXZb2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794748287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-Virus-Scanned:
	 X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0we2ggMCyyLsxP91k/l3tZHZ1zJ+DAhwvfQ74XTviqI=;
	b=hrQpPiRHyticj6oQhH2ETyDYTwD1Z0noPIa8alQ5cTDNG3N/5cvOipwNNr50U9/xu9dm
	 ke7XxmLu/9yuslVmJ489WYGHSvHK1E59hsR22BXsIveWJwFeTtceVEGKPnTMzQbIO2CE1
	 7DREiJu2A1BzmN5e7GWbID1ZUNhkuRgpBEA8KNkc/qSIPBwPPTW3cCcMoEc/2AZiyJNKt
	 1KtEgZ7+BjYph1vfGS/ZhYxoEKuhmcAmMT2WMI5//8pXzTW3iomeDbjrWBXGlSzAW7UhN
	 YLmofIkWv3V03pYbyc1XiVzJ1Q1BvvB6IPySdSPEYiGwC2RJ0PxzkXA0Slm8rJ6AMWQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794748287;
	bh=0we2ggMCyyLsxP91k/l3tZHZ1zJ+DAhwvfQ74XTviqI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IK0F1aSn2FNtrlesrX8WeVz4THNd4Sgm0wG/vCCil7a9zKJhAChHp0kWy3J29fk9O
	 xUYoQZetcYu8LduVwkJVeqLYYnNVPTQQZE4aZE/RFekdXCR5wlfifMMf/+UUa3e2h4
	 kVBuvapI1sGvyAtYyngtccWpkwYL0zP0Y1ecZZaFBV9+TEVK8NO+H5HxlJ6blDKP5L
	 uHi+flouYSes2tf7V6pPNklBem5FodQS3X7zKKbsf3eyhe6MGR2kMcR6G4JjbqJ13D
	 T2IyJC5E0kYP7YhWxqAnaHgSgon/ui/u0ZYKuVqGv2b5FZ+oA30t/eWda1NaosGomn
	 Yt8BZWiUU57wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A2E76062B;
	Sun, 15 Nov 2026 13:11:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C169B70B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B67B580FFE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:43:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tniwa57PQtvY for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 06:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57B9280FF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=wilcox101@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=pB32TEoo
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57B9280FF3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 06:43:29 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AD58847F0; Sun, 15 Nov 2026 07:43:28 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20686844F6
 for <u-boot@lists.denx.de>; Sun, 15 Nov 2026 07:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wilcox101@gmail.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-5641f26ce05so1903222b6e.2
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 22:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794725000; x=1795329800; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0we2ggMCyyLsxP91k/l3tZHZ1zJ+DAhwvfQ74XTviqI=;
 b=pB32TEoohgraGsA2Wz/gaOcVIN0d2oVejU670PYw4eZsgrOHsuh27zrJ4srQFvJG79
 se06OA+UKWwsrbIXktnxld1XCRxFKGrkBszlTcPSn2M6DqjqIWQXcTKm6Wm9ceCae38W
 VPNGapciEh5Vc6YBIcn9zpGgyuJTKDWuyuIMNWxJUpNzTyV8SnN9rfl2XmE/tZE0bs19
 v4zygt9/WwQd5pWnOpJ/+jGmN3qwXY+vNojWnG6uvEGaAYjU+ervhMEQd9AiBaVBzJ36
 UL9UsIKiFCnTeHvWtgAug5K8b0vrl6/LQSmaJk0H02loQBWV/yhzZUMJUwJi1DMeN/tO
 iqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794725000; x=1795329800;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0we2ggMCyyLsxP91k/l3tZHZ1zJ+DAhwvfQ74XTviqI=;
 b=gXKfebX9SPgY8pBoKKIeHM6zLicXJx/hNNRqlFZQBFGilBUZj3yTsZQU7EGzB1bmqp
 XGGwkBV+QbkvTntL45UOF+JLyAAI/n7/gd6G0yPOwUacvTNNEejKGZM55CdoVpZoLUi/
 V/IWW7rOthfR7QbTAK14gvEOoO0mZxkmXXyABMraBR88MyduFtP8TZJtxL6kUBLt1XqP
 GW/iokHb2e1Io0h1BEdlb6Gyw/yL6a+tzOmY0jOMqM4P9J+FHltj90itJreoXW7Gel5G
 FnmDdY2KfoOh3ZPf4mXT9Xj0Mfvv178J25r/C46rmOyW3wwirTf6jq5BP+Brn1DJ+T/T
 cMUA==
X-Gm-Message-State: APuU4Z9gksR35frB0E0GvTGU8iURLsK+aSSGOJYC7EHRmmGsAIqf4Uxc
 +/QHrY6LEPPXPZBuFozASyKFkWn25GT9XAcdEUbuEGfO9Qichq2FtL7H/jp02e14pse1HBg2SlA
 3LYTH0irB2QpfBvc+IQ+Q/2Z8IV7ik0MCpg==
X-Gm-Gg: AYBFou22qztGPNt8XPT8zHHwdxG7vMdxQwOnM02Oh6R83JGPqOm4TnFsWSr9c8zG7+x
 1WyktGn0XfFDmpi1+7khxege/vx3rd8KemWzxaNMN+p8W830QFYqB30e4qqE9bQqD15M78WQAqf
 elTLmOPn0lnsdBsl2vFfm7zmQAm0ohYA2YffG9xznXULXAIKBh1ZDC0nYXeWwM2NoOyp4L/lXMZ
 8wMZyY3pnAl/XhK8NEaQi8FPXZMlmWsvvz0VqRO90aXQAAl1Bjvwm+3ZY3GW43UXkTEgdmkDCQe
 XnkXXhsedjWJTaHKYvDymmwkaQI/VWNBQtbSr7DvSnie3h084Ts/XKd9d/E643u7PSwgOWP5lpf
 cA3qb7YdsOhqnxDYLXLHa86JifiOsORkmw3XXzWE2wF+Zb1rEl7PG+ECr55fHGR2ImGGjmrMNYm
 OgBhUo1unDav4B/CZAI2pXXqI7bC3TOByhMam6TU+OJWdrtyrBznONglXEuDRXp2I1XvweCbg=
X-Received: by 2002:a05:6808:300c:b0:564:30ff:6cca with SMTP id
 5614622812f47-56e65a37d8emr5562584b6e.60.1794724999648; Sat, 14 Nov 2026
 22:43:19 -0800 (PST)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Nov 2026 01:43:19 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dale Wilcox <wilcox101@gmail.com>
Date: Sun, 15 Nov 2026 01:43:19 -0500
X-Gm-Features: AclHuK_qsHR-Rjxm7v3IB0rVnI-xP_PyDLPUDR3JLkoHEJjqb1ryaQpI0qOSyXQ
Message-ID: <CAKtUr1WwwZfggtY3xA5cComHhJcbjNVm_fSrwxDPHWh60E1i8w@mail.gmail.com>
Subject: binman: SPDX tag "Intel" on lib/binman.c and include/binman.h?
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
Content-Type: multipart/alternative; boundary="00000000000012daf806604afaea"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 15 Nov 2026 13:11:25 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000012daf806604afaea
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

lib/binman.c and include/binman.h carry

SPDX-License-Identifier: Intel

but their headers say "Copyright 2019 Google LLC, Written by Simon Glass",
and the
rest of binman (tools/binman/*.py) is GPL-2.0+. The tag has been there
since the
files were added (present in v2020.04, not in v2020.01) and is unchanged in
v2026.10.

"Intel" is not an identifier on the SPDX licence list and has no text in
Licenses/; in-tree it otherwise marks Intel-released x86 code
(arch/x86/cpu/quark,
the FSP configs). So it looks like a copy-paste slip rather than an intended
licence.

We noticed it while generating licence notices for a board that enables
CONFIG_BINMAN_FDT, which compiles lib/binman.c into u-boot proper. Was
GPL-2.0+
intended? If so, would you send (or ack) a patch changing both tags? Only
the
copyright holder can confirm the licence, so we haven't sent a patch
ourselves.

This message was drafted with an AI assistant (Claude).

Thanks,
Dale

--00000000000012daf806604afaea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Hi Simon,<br><br>lib/binman.c and include/bin=
man.h carry<br><br>    SPDX-License-Identifier: Intel<br><br>but their head=
ers say &quot;Copyright 2019 Google LLC, Written by Simon Glass&quot;, and =
the<br>rest of binman (tools/binman/*.py) is GPL-2.0+. The tag has been the=
re since the<br>files were added (present in v2020.04, not in v2020.01) and=
 is unchanged in<br>v2026.10.<br><br>&quot;Intel&quot; is not an identifier=
 on the SPDX licence list and has no text in<br>Licenses/; in-tree it other=
wise marks Intel-released x86 code (arch/x86/cpu/quark,<br>the FSP configs)=
. So it looks like a copy-paste slip rather than an intended<br>licence.<br=
><br>We noticed it while generating licence notices for a board that enable=
s<br>CONFIG_BINMAN_FDT, which compiles lib/binman.c into u-boot proper. Was=
 GPL-2.0+<br>intended? If so, would you send (or ack) a patch changing both=
 tags? Only the<br>copyright holder can confirm the licence, so we haven&#3=
9;t sent a patch ourselves.<br><br>This message was drafted with an AI assi=
stant (Claude).<br><br>Thanks,<br>Dale<br></div></body></html>

--00000000000012daf806604afaea--
