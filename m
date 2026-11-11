Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F0606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SpDR02Ub;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oSB/Plv1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DFDE6071F;
	Wed, 11 Nov 2026 08:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z1CKflji_XM8; Wed, 11 Nov 2026 08:56:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F1E6860657
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794387403;
	b=l/EqIhqAhRonyR5dAjVEtFaHApGPG3+rjlaLnfVRV6BBUtZd+gTSPa/EPSGpvZKzteoJ
	 HiYBzrWvv3R5Wq2hjFN8LT+WeTlydiYU0ct24tyOA7T2UpwHQPfkUFQi3sJ1MuJQ/OcoG
	 LlqmY6g3mvYK5FMpAAPWkZ5WIhYSBWESmf6krfbeVdjotStr1mTnt34d5aluq30MwFad4
	 7Ia2JpJGziLP1UCKe2/w4Q363o0LI3yk8DapHuQgT7bmnSVqe3bEQK4IfiFNP0g96BoOp
	 UNxMgIdzhRjBpdZvHKpl3MyQO38O2kAaEFY7GoOmmYVEib3DHdkjoEoRhxypzK5Bn1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794387403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JUUXeFtwvquNigvAOV9+A9lbAtHldbBie0YYzSQHtnE=;
	b=EypQOT9EK6mLSCO0+KPGp0uio0g2O9A9nT1zjvIPZbVn0qthCkmlUo4wmWHUk/yTkkWj
	 JEglqplt7S0kcqxGegTXffz3PS2C5c+WmwPwEn+e7A6m138QRs+70n5nSz89BbpZFQ9jC
	 8bUsGPw8OQB7yBWEEY5PQg7NNz4e+7bSyulSy+5YJPUz8YjvJ21abSqbM56X2O7LpiAw4
	 SL8/WlumYslknW21MfDnrNGXmEEUlZZSTdDj6ChxIDb8Xa9H0J48bGy7RoPHOr/EzoAzE
	 twF1aHsE7e2oGf0uhzFHStzqXkXhLisSEbX9K643326OQzKN9Lkn99JJmsWphhGyY/g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794387403;
	bh=JUUXeFtwvquNigvAOV9+A9lbAtHldbBie0YYzSQHtnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SpDR02UbtwsHNAnjBkpV6ukvSfhVfYda+R7yBrSwy70gFmyLwc8CNoLT67Q4TZWje
	 HutqNrO9LItJRrTgpNT9l+uDbFo4tUYWZKBUSSzVRBJtqWA/fNR+ukpE0uaxUIE8D3
	 xUKi8OoVSEUq6RRm0af9ZgXLPem/idoI1EjcRo4SmzfoFOlfenSpmu+iDwOdlF1jNy
	 EUMDPx0fd7LIaHfe3mvLrf7U5SCJCXGEfyALzj7ZmXyNHe2oTk+Uo8bGDLbLQf+Y9F
	 OUgVqptDsMN8AviKsVd623AQ1g7s4zuFPhqfkrQjSwZvVWeySOVpwSGXuysDSk5qk6
	 j/goRcNxAk0kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1E6860657;
	Wed, 11 Nov 2026 08:56:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7D0128C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 776774080D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8T9M9HU0LIkW for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:56:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 596A240718
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=briansune@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=oSB/Plv1
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 596A240718
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:56:38 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-8470d7d430fso1548028a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 00:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794387398; x=1794992198;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JUUXeFtwvquNigvAOV9+A9lbAtHldbBie0YYzSQHtnE=;
 b=oSB/Plv1FTX+8qmzCND3uL+UG6AW0rgELEZWCofPR9HHuuze2QPPor2w+oAmEh44tA
 w33tr396H10aH4KO0CFJkn8DJ8yxqTRSekPDw4SI7G39NEMOgBzxc7+OUVtQu1yEuxPB
 P9SvICWcpxTV3YDIw/Ir0GfZNnB/0yiVmPpixS8jacpIHNUF9MOCgGpxZax/otq+hP8L
 MgqkRBNJhT7/WhboVe+dkrWY0+Mo5HMQlVw6nlSEz5k8bJJsCC4WKc0ouCzapjQx0q0U
 KN4c1PW15Q5claAtgZw2LYTGuykdH3ySap5dyj8G89XXWaJObXkGPl7XI7J6OX7oIQX0
 6ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794387398; x=1794992198;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JUUXeFtwvquNigvAOV9+A9lbAtHldbBie0YYzSQHtnE=;
 b=KeyGQbWMtPq7e3CYyNqb/3+VMex77VzA4eUELg+WkxHLkXrDDh/PMyoCanmdtswdVN
 lYoN1Ew++iCPBL66cLoIczU4fLrYgaOcUUVsRgGxoXEvIW3EP2wn5RgmLgUyE5/wwQN+
 eU2379ldL9dn4A8lfREfuIlc7eYb8oFaHilxJ6UPTIo4xHPEXo5fliWEmNWEEZVM1JeV
 CrbXYxo9cLA/bkiXo27CTIgTE1cobhar229skEjDPPuGx58JrDbJE2xSoQRkMCSVTko0
 0HRID14Np5jMvRr3r0v1X0mjeclJbEQaZVcPBD1BQ6qc10Q9TobGH/02DPZEZ8+ZA7gN
 CEUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFaDcRG7T91rL52G4/gPiuL8i1GzjF59Y9Bb63QnSKyUHrn54B26qrT+JtO+9cDjyDtSTGJG88=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+INmfivbBYw90lpRBXdgApL/K0ijfO2Cw9mzZY0BoUnRJaBJOG
 ggGdAPm3GlG7OvrfNu2X0PLGhBJv/1AoCiy6iWu/e2OtHmryFnqT5xaORtTSaf2VDShQ+ZUYFcG
 vkVd++Wd2VVh9Cx02OOek9jCVuOGojoI=
X-Gm-Gg: AYBFou2Yuv5EH0z5V7ZSjUbMO4NNtmIi+VNcCymAyo9Ak/74/+VYTT8+CV9eKv7VSZU
 d0Dk7oN1EF0r/lfM63iJhbHLm5F0l/+rkUWKok+FTpxahPJKBaLwERmIzEarsB4z0LkYWc0xh2D
 eAL3PDoiRuuWQNSeO2rvfl/0jhTZCaI2JQDhXCl4t/vbKHEBeWKCNIvQWvlaTV9SIYX2/edP+qZ
 LzgD5fcyAPX1NiNVUgA4dRGh83lDi/9CClau6pbvTXf4BAiKg5/dYxbaYjo/jrcjZ1pGXHNgLTK
 4QNw9ZUfR4176Q0caT6Heh2eYMPQRc0rQS7ezFR3m5pyBBDpIzDu+NoQzwEYgY9JdoOsY/14z77
 Y0Lq5fQ2Jjtqy/hAh2tsDb3KR1gWizc7dNovODg==
X-Received: by 2002:a05:6830:2406:b0:818:56c:a8f6 with SMTP id
 46e09a7af769-860f29c7d06mr1595615a34.26.1794387397658; Wed, 11 Nov 2026
 00:56:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111062128.215998-1-briansune@gmail.com>
 <7d5f0c9f-6f04-4773-a0f6-1cab069a2f77@amd.com>
 <CAN7C2SC+Xzh-MsgoS5zYq2piDajpLh8BzGTkBdzCQ396oLgEPg@mail.gmail.com>
In-Reply-To: <CAN7C2SC+Xzh-MsgoS5zYq2piDajpLh8BzGTkBdzCQ396oLgEPg@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 11 Nov 2026 16:56:26 +0800
X-Gm-Features: AclHuK_HJld-pTNefZ4IiXUxoU7V3tE1bJr2-El6FxzjrH4S83t_dzL0Yl5GIEc
Message-ID: <CAN7C2SBrz0L3GmJMhT4Z84oWeZw8CRrJk8AW8R9itSQiJ=Aeew@mail.gmail.com>
Subject: Re: [PATCH v1] arm: zynq: Add missing handoff script to XSA flow
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 4:37=E2=80=AFPM Sune Brian <briansune@gmail.com> wr=
ote:
>
> On Wed, Nov 11, 2026 at 4:13=E2=80=AFPM Michal Simek <michal.simek@amd.co=
m> wrote:
> >
> >
> >
> > On 11/11/26 07:21, Brian Sune wrote:
> > > This patch adds XSA handoff for ZYNQ core modifications.
> >
> > Add XSA ...
> >
> > >
> > > User now can place XSA file next to the board folder where auto
> > > generated from Vivado build flow.
> >
> > What would be intended workflow?
>
> The intended flow is any XSA changes from Vivado build:
> i.e. changed MIO unused or EMIO rerouting etc you have to update the boar=
d
> file ps7_init_gpl.c to ensure boot follows.
>
> >
> > >
> > > Signed-off-by: Brian Sune <briansune@gmail.com>
> > > ---
> > >   arch/arm/mach-zynq/config.mk | 97 +++++++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 97 insertions(+)
> > >   create mode 100644 arch/arm/mach-zynq/config.mk
> > >
> > > diff --git a/arch/arm/mach-zynq/config.mk b/arch/arm/mach-zynq/config=
.mk
> > > new file mode 100644
> > > index 00000000000..2680db85d25
> > > --- /dev/null
> > > +++ b/arch/arm/mach-zynq/config.mk
> > > @@ -0,0 +1,97 @@
> > > +# SPDX-License-Identifier: GPL-2.0+
> > > +#
> > > +# Brian Sune <briansune@gmail.com>
> > > +#
> > > +# HANDOFF_PATH
> > > +# ------------
> > > +# Unset - Board path where ###.xsa locates and "ps7_init_gpl.c" shou=
ld be placed.
> > > +# Set   - Custom path points to "###.xsa" file.
> > > +#
> > > +# HANDOFF_KEEP
> > > +# ------------
> > > +# Unset      - Clean ps7_init_gpl files.
> > > +# Set        - HANDOFF_KEEP=3D , Clean ps7_init_gpl files.
> > > +#      HANDOFF_KEEP=3D0, Clean ps7_init_gpl files.
> > > +#      HANDOFF_KEEP=3D1, Backup header files and rename to "ps7_init=
_gpl.c.handoff_backup.<timestamp>".
> > > +#
> > > +# Version Log
> > > +# -----------
> > > +# Date - 2026/11
> > > +# 1.0.0 - Initial Release XSA handoff for custom boards and existing=
 boards
> > > +
> > > +ifeq ($(CONFIG_ARCH_ZYNQ),y)
> > > +archprepare: zynq_handoff_prepare
> > > +endif
> > > +
> > > +define COMMENT_C_FUNC
> > > +     FILE_PATH=3D"$(2)"; \
> > > +     TEXT_MATCH=3D$$(printf '%s' "$(1)" | sed 's/(/\\(/g'); \
> > > +     C_FUNC_HEAD=3D$$(awk "/$$TEXT_MATCH/ {{print NR; exit}}" "$$FIL=
E_PATH"); \
> > > +     if [ -n "$$C_FUNC_HEAD" ]; then \
> > > +             C_FUNC_HEAD=3D$$((C_FUNC_HEAD - 1)); \
> > > +             C_FUNC_TAIL=3D$$(awk -v start=3D"$$C_FUNC_HEAD" '/^\}/ =
{if (NR > start) {print NR; exit}}' "$$FILE_PATH"); \
> > > +     fi; \
> > > +     if [ -n "$$C_FUNC_HEAD" ] && [ -n "$$C_FUNC_TAIL" ]; then \
> > > +             sed -i "$$C_FUNC_HEAD,$$C_FUNC_TAIL s/^/\/\//" "$$FILE_=
PATH"; \
> > > +             echo "[INFO] Commented out lines $$C_FUNC_HEAD and $$C_=
FUNC_TAIL."; \
> > > +     fi
> > > +endef
> > > +
> > > +zynq_handoff_prepare:
> > > +     @set -- $$(awk -F'"' ' \
> > > +             /^CONFIG_SYS_VENDOR=3D/ {v=3D$$2} \
> > > +             /^CONFIG_DEFAULT_DEVICE_TREE=3D/ {b=3D$$2} \
> > > +             END {print v, b}' .config); \
> > > +             VENDOR=3D$$1; \
> > > +             BOARD=3D$$2; \
> > > +             if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
> > > +                     exit 0; \
> > > +             fi; \
> > > +             BOARD_DIR=3D$(srctree)/board/$$VENDOR/zynq/$$BOARD; \
> > > +             if [ "$$HANDOFF_PATH" ]; then \
> > > +                     echo "[INFO] Using manually specified handoff f=
older: $$HANDOFF_PATH"; \
> > > +             else \
> > > +                     HANDOFF_PATH=3D$$BOARD_DIR; \
> > > +                     if [ ! -d "$$HANDOFF_PATH" ]; then \
> > > +                             exit 0; \
> > > +                     fi; \
> > > +                     echo "[INFO] Try auto-detected handoff XSA: $$H=
ANDOFF_PATH"; \
> > > +             fi; \
> > > +             TEMP_DIR=3D$$(mktemp -dp "$$BOARD_DIR/"); \
> >
> > When you do out of tree compilation you very likely don't want any scri=
pt to
> > change your code under your hands.
>

There are some typo here:
This script will NOT execute when XSA is not given next to the board
folder nor custom flag setup.
So it will simply exit and silently cont'd. And the intention for this
is run > make prepare phase.

> This script will on execute when XSA is not given next to the board
> folder nor custom flag setup.
> So it will simply exit and silently cont'd.
> While the intention for this is run > make prepare phase.
>
> >
> > I don't have issue with this idea to automate this but I see this more =
like a
> > tool not something what you want to run in every build. Please look bel=
ow.
> >
> >
> > > +             trap 'rm -rf "$$TEMP_DIR"' EXIT; \
> > > +             XSA_FILE=3D$$(ls $(srctree)/"$$HANDOFF_PATH"/*.xsa 2>/d=
ev/null | head -n 1); \
> > > +             if [ -z "$$XSA_FILE" ]; then \
> > > +                     exit 0; \
> > > +             fi; \
> > > +             echo "[INFO] XSA: $${XSA_FILE##*/}"; \
> > > +             unzip -q -o "$$XSA_FILE" ps7_init_gpl.c -d "$$TEMP_DIR/=
"; \
> > > +             if [ ! -f "$$TEMP_DIR/ps7_init_gpl.c" ]; then \
> > > +                     echo "[WARM] XSA unzip unsuccessful."; \
> > > +                     exit 0; \
> > > +             fi; \
> > > +                             if [ "$${HANDOFF_KEEP:-0}" !=3D "0" ]; =
then \
> > > +                     echo "[INFO] Preserving old GPL files..."; \
> > > +                     TIMESTAMP=3D$$(date +%Y%m%d_%H%M%S); \
> > > +                     for f in "$$BOARD_DIR"/*.c; do \
> > > +                             [ -e "$$f" ] || continue; \
> > > +                             echo "[INFO] $$f -> $${f%.c}.c.handoff_=
backup.$$TIMESTAMP"; \
> > > +                             mv "$$f" "$${f%.c}.c.handoff_backup.$$T=
IMESTAMP"; \
> > > +                     done; \
> > > +             else \
> > > +                     echo "[INFO] Clean old GPL files..."; \
> > > +                     if ls "$$BOARD_DIR"/*.c >/dev/null 2>&1; then \
> > > +                             rm "$$BOARD_DIR"/*.c; \
> > > +                             echo "[INFO] Removed old GPL file..."; =
\
> > > +                     fi; \
> > > +             fi; \
> > > +             sed -i 's|#include "ps7_init_gpl.h"|#include <asm/arch/=
ps7_init_gpl.h>|g' "$$TEMP_DIR/ps7_init_gpl.c"; \
> > > +             echo "[INFO] Masking GPL unused functions..."; \
> > > +             FUNC_NAME=3D"ps7_config(unsigned"; \
> > > +             $(call COMMENT_C_FUNC,$$FUNC_NAME,$$TEMP_DIR/ps7_init_g=
pl.c); \
> > > +             sed -i 's/^ps7_debug(/ps7_debug(void/g' "$$TEMP_DIR/ps7=
_init_gpl.c"; \
> > > +             sed -i 's/^ps7_post_config(/ps7_post_config(void/g' "$$=
TEMP_DIR/ps7_init_gpl.c"; \
> > > +             sed -i 's/^ps7_init(/ps7_init(void/g' "$$TEMP_DIR/ps7_i=
nit_gpl.c"; \
> > > +             sed -i "/For delay calculation using global timer/,\$$d=
" "$$TEMP_DIR/ps7_init_gpl.c"; \
> > > +             sed -i "/int\nps7_config/,\$$d" "$$TEMP_DIR/ps7_init_gp=
l.c"; \
> >
> > This sounds very similar to
> > tools/zynqmp_psu_init_minimize.sh
>
> I am not aware that Xilinx has this as I moved from socfpga and did
> similar things.
>
> >
> > obviously you target Zynq and not ZynqMP but one part is extract it for=
m xsa and
> > second about cleaning. And there are much more things to clean.
> >
> > You should divide it to two parts.
> > 1. just unpacking xsa and installing it to certain configured board
>

Ths XSA so far I understand on ZYNQ only requires 1 file "ps7_init_gpl.c"
All other hwh etc is not a major use to define a board / custom setup.
And the unzip + cleanup actually only require when user would like to
setup a custom board
or change existing board settings.
I also have to ammit I don't have a full log on how old Vivado pack
things and handoff file changes
are required or not.
I only tested on Vivado exported XSA 2024 version, where old 2019 uses HDF.

Meantime, this patch is intended to work on XSA so if 2020 to 202x XSA
export is kept it
should be good to go.

I think the easiest and cleanest way to support handoff on ZYNQ is
just passing "ps7_init_gpl.c" from
XSA.
And if user do not change any things it make no sense to unzip XSA aka phas=
e (1)
Then phase (2) dies together.
So any changes will always 1+2 while 2 optionally keep or overwrite
old "ps7_init_gpl.c".

So far the board folders for ZYNQ also follow this structure and no
variants are found.

Thanks,
Brian

> There are actually not installations at all as 2024 Vivado generated
> XSA that cannot directly
> extract and place w/o build fails.
>
> > 2. ps7 cleanup
>
> The cleanup does have a flag for users to select keep or not.
>
> TBH: I am also amazed by why Xilinx did not include XSA handoff flow
> between upstream u-boot.
> I do understand that most of the users use the Petalinux build flow on
> top of Yocto.
> But this setup completely wastes a lot of computation power and complex t=
hings.
> I run this script and boot my board w/o any issue when simply passing
> Vivado exported XSA.
>
> Any feedback is Welcome =3D]
>
> FYI
> I also noticed the board flag of the ZYNQ is kind of funny.
> I had to use device-tree labels in this current script to make things
> work normally.
>
> >
> > Thanks,
> > Michal
> >
> >
> >
