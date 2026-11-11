Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58E2606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sVy4rjPH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7+3OmVM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8660C408D2;
	Wed, 11 Nov 2026 10:58:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wkJQe5WSNeWR; Wed, 11 Nov 2026 10:58:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7710640598
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794394681;
	b=BgarwYIBEflHSghKL0cZXPonXsR2n76owmhoWhDc8NsGZAzQE0UOr5+geIf8Ls7mLUUy
	 XyOFFCfOhgCmkBgbOGvtqlsqdk250HafoXXHiuCxnwpLVpAw9+2jXmHpSDUR1Q4VAeWaq
	 clxXml+u8TZ9vOOLmcsiL9OKlx9Se/ag8Fg+KzhTIvRSbh0enfubCe6FdgZPapg2jBxXM
	 0tm70pTsqQcgodvhmMntydqvK3hL1xiP5t5y7+Qe0DdScLN+s1oMJqEF0qoFXvdIR8GDm
	 R2Qk0u/+/d8F9X4JBHzUBqRLi18MAHHVak65P5rxabm4w8FXifFWQFuU1mPkk+vXkmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KwTohDLHpmLHUZNmU+OqVjNyXxTZGEgs4wDmXx6bdAw=;
	b=cRifj08qELIy4IubTHUn7DaT1IQcQNCVDwyxvd0D9SFQSQQRRiIMRDfJ810MYaKGQAig
	 jYUwzko0jhC1lx8PNIx7kHmtkbDRmE7fwR2SbdQBiqe1tMexATRlZJ/EAtpUy0bvcM/IO
	 wTcJQuBM3X8stLsHnxhjt5qST+kLgKuEQ1/PLY5vkgWX0kRfvaO1/CV/wrRDsqv6wlndu
	 lC1wNHvKU4atoI4lZh8/eqO/fEsb8RvtwaRWG1ZW0MliE+gtn8cKrxV4aUyG2y4OAKxyu
	 l/PbBfFtiPkMXVKy4Mf2rLxToUD7igFZWoLDr9jELGgwIU+gSZ96MgwZFYmiTF2yC0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z7+3OmVM;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794394681;
	bh=KwTohDLHpmLHUZNmU+OqVjNyXxTZGEgs4wDmXx6bdAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sVy4rjPHYzkBFHzUdfOWAE9yc55/reytgbUKQCZUXVUwykoSJLDxMzQ+BRduWwuph
	 klPree2pJcMpQeRkVSLXhvcD+rAbR5efOnVmoD2BnS9UaB7zaqFpvfzKoZSQ1S1t7g
	 R18m2UeDMTdCzTBR2R3gZRjmevWVLNlZtHnQkZz2SOtScXR+Ej8db7Gdx1rgph9xJq
	 SWjz8ErkGnPmmup6T7EmRqIYQ0gIgBa9A1WDbN2EYIF5cnBCGQGVWRF29jFAsXloD3
	 uD9dyFdfa6HKRz3IAB2rj+B1/CdU7EYFO/jArnCj6LmS1m6WuQUDu8AFEcvYq9pnif
	 Kz0FrFIgsgchw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7710640598;
	Wed, 11 Nov 2026 10:58:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 47EA117CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38C1240598
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:58:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j5EfSXx5_Vcw for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:57:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0E6E940572
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=briansune@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Z7+3OmVM
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E6E940572
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:57:58 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-833e671ee9fso2975618a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794394677; x=1794999477;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KwTohDLHpmLHUZNmU+OqVjNyXxTZGEgs4wDmXx6bdAw=;
 b=Z7+3OmVM1VzEBja6+vizVFBonVGYXeSI4Y88B84LZk1x6tdNIPe1S9UCo0A38ZpbPT
 eeeGc4gX+HgKzx+FsDSmsT5/JdWYYCVR1If+WIYv8D7MlhxzWNILTf1aP7CeUZO/n8ae
 jPJPcuG22IGig4epl6j/Iru0yL/V7Zl8rED0i90WXKtfJXwLlmMH7HGDGzLsWtKqitm5
 mpWqshfD3feXfAeRnnPm7TtcjOkQ++UoidcE1SUnKZwR0zLRaqqtRgKYYx28AeFR3oUb
 gtc4uG62ffp+CQIj/xEAZY1YzKnjhsasy+VzcfOlyb05Dsq1jEiteTb6BcKlvNqgpvx5
 axoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794394677; x=1794999477;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KwTohDLHpmLHUZNmU+OqVjNyXxTZGEgs4wDmXx6bdAw=;
 b=XxXXd10lDfZawZ9NTWeXfp4+1VdYVEv1wpPNZ13umw9b2IA9ovnELyrLhsXyx/0iLm
 NOEiC5OxTlGFZjEUiyMtjHdsW8N38s0NmtWInDKjBgQcBv/8AKYSt055r8bdaI+hnqb/
 3cukqlDQ1OkDsN0m5lepPvUGU1jwaLNn5K/lVjfFAVizIQx9Gifcvua1jNqs1AJy01N3
 ucHOVjYO3iZnHzJRQgMMLeVc69y4R9Ex4/AnayCyiJQP3uT2/NZC8zQB1HAw5fX1pGTj
 xB1Q5ixlhEgw2eJ5amiv36TBg/r8g8ZgwSqkdKxYsnbEtWaNisuPAtyMT1SiRPV9g/hk
 pgEQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEehC1is3l2IqVGu+IW0poSHbFtvIwvn6u4dkaTMbQi6Zmn4oIgyMjfvaTT4UN0TQ54HB4IgRE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Lw0SidlaiZbppwKzqy2Vd890Z/JJUH8G9FhqFNi9nLO18irKc
 isgKuvDOSi4qJbhTbjbl6pHOwPqkbHqHVw1iUAadm7o+9ahuTzNR+hXFVVagPyDhWzENCc7aUTq
 EHykeAWBw+8mtDf9iK97UjrJ0kRFsnw7hLLbnWVY=
X-Gm-Gg: AYBFou2ovaoj2r0chwnzGhTiOO98pnqdZQvT5/n+ikJgwfQSVFjLTPUk/2RSKdshs2x
 NfubuTu57Ml/ptUFuaCyEJbIyE39Onb3v/PLK3JALcO5jv2gTRSkqtRdm0Fb9a8QfcosmdjvdgB
 WGHnbWI+15hEjcOf51Cwkmt6/4xtP/H9Pe6uA5S2DU3X2qUbUp5vfGFsUjC3Vwicsyi86AkWn/7
 PISpRGCppCKEHAKsKfk0S+kkjv6LRNXTORlBADajjgmZiRgo9nL8TBXrOcYoPodE4SO+dw5PN1h
 lXHNsSMyn1Fw8F8NbnlV3GI/CHJXzVAoYx7JxRDL9BexoPhML5yoo4yDnkdmZw6qxjlHoA9odb0
 svHSb7tmLzEYJxknXH9TJ9D/SFiDsKOnbbTyU1Q==
X-Received: by 2002:a05:6830:4c07:b0:843:8982:9528 with SMTP id
 46e09a7af769-860f28ce129mr1681839a34.19.1794394677290; Wed, 11 Nov 2026
 02:57:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111062128.215998-1-briansune@gmail.com>
 <7d5f0c9f-6f04-4773-a0f6-1cab069a2f77@amd.com>
 <CAN7C2SC+Xzh-MsgoS5zYq2piDajpLh8BzGTkBdzCQ396oLgEPg@mail.gmail.com>
 <e2cb16ac-fb98-49cc-a092-8f3026409c43@amd.com>
In-Reply-To: <e2cb16ac-fb98-49cc-a092-8f3026409c43@amd.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 11 Nov 2026 18:57:46 +0800
X-Gm-Features: AclHuK-chCJ_yt3GSLscbtv1QI5B85MPrJzhVGwpbcv89GTjWQ7nZOiXLcmqeSc
Message-ID: <CAN7C2SDaY-02mJgZdNZCk=0WaBL+xEHKa2nNVyg1fbEit8yVVw@mail.gmail.com>
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 6:28=E2=80=AFPM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 11/11/26 09:37, Sune Brian wrote:
> > On Wed, Nov 11, 2026 at 4:13=E2=80=AFPM Michal Simek <michal.simek@amd.=
com> wrote:
> >>
> >>
> >>
> >> On 11/11/26 07:21, Brian Sune wrote:
> >>> This patch adds XSA handoff for ZYNQ core modifications.
> >>
> >> Add XSA ...
> >>
> >>>
> >>> User now can place XSA file next to the board folder where auto
> >>> generated from Vivado build flow.
> >>
> >> What would be intended workflow?
> >
> > The intended flow is any XSA changes from Vivado build:
> > i.e. changed MIO unused or EMIO rerouting etc you have to update the bo=
ard
> > file ps7_init_gpl.c to ensure boot follows.
>
> It means you want to just move xsa to your board which will unpack it
> automatically.
>
> My suggestion is to pretty much do this
>
> ./tools/zynq_<whatever with xsa> <path to xsa> <path to your board>
>
>
> When I placed xsa to board folder your code just run that operations all =
the
> time. I don't think this is the best workflow.

No this is the only way we can simplify the flow.
Meantime you need to check this makefile script more at the top section:
Once the XSA next to the board/<NAME>/xxx is not found it will exit
and nothing really slows down.
This is a preparation step where build should always do.

>
>
> >>
> >>>
> >>> Signed-off-by: Brian Sune <briansune@gmail.com>
> >>> ---
> >>>    arch/arm/mach-zynq/config.mk | 97 ++++++++++++++++++++++++++++++++=
++++
> >>>    1 file changed, 97 insertions(+)zy
> >>>    create mode 100644 arch/arm/mach-zynq/config.mk
> >>>
> >>> diff --git a/arch/arm/mach-zynq/config.mk b/arch/arm/mach-zynq/config=
.mk
> >>> new file mode 100644
> >>> index 00000000000..2680db85d25
> >>> --- /dev/null
> >>> +++ b/arch/arm/mach-zynq/config.mk
> >>> @@ -0,0 +1,97 @@
> >>> +# SPDX-License-Identifier: GPL-2.0+
> >>> +#
> >>> +# Brian Sune <briansune@gmail.com>
> >>> +#
> >>> +# HANDOFF_PATH
> >>> +# ------------
> >>> +# Unset - Board path where ###.xsa locates and "ps7_init_gpl.c" shou=
ld be placed.
> >>> +# Set   - Custom path points to "###.xsa" file.
> >>> +#
> >>> +# HANDOFF_KEEP
> >>> +# ------------
> >>> +# Unset      - Clean ps7_init_gpl files.
> >>> +# Set        - HANDOFF_KEEP=3D , Clean ps7_init_gpl files.
> >>> +#      HANDOFF_KEEP=3D0, Clean ps7_init_gpl files.
> >>> +#      HANDOFF_KEEP=3D1, Backup header files and rename to "ps7_init=
_gpl.c.handoff_backup.<timestamp>".
> >>> +#
> >>> +# Version Log
> >>> +# -----------
> >>> +# Date - 2026/11
> >>> +# 1.0.0 - Initial Release XSA handoff for custom boards and existing=
 boards
> >>> +
> >>> +ifeq ($(CONFIG_ARCH_ZYNQ),y)
> >>> +archprepare: zynq_handoff_prepare
> >>> +endif
> >>> +
> >>> +define COMMENT_C_FUNC
> >>> +     FILE_PATH=3D"$(2)"; \
> >>> +     TEXT_MATCH=3D$$(printf '%s' "$(1)" | sed 's/(/\\(/g'); \
> >>> +     C_FUNC_HEAD=3D$$(awk "/$$TEXT_MATCH/ {{print NR; exit}}" "$$FIL=
E_PATH"); \
> >>> +     if [ -n "$$C_FUNC_HEAD" ]; then \
> >>> +             C_FUNC_HEAD=3D$$((C_FUNC_HEAD - 1)); \
> >>> +             C_FUNC_TAIL=3D$$(awk -v start=3D"$$C_FUNC_HEAD" '/^\}/ =
{if (NR > start) {print NR; exit}}' "$$FILE_PATH"); \
> >>> +     fi; \
> >>> +     if [ -n "$$C_FUNC_HEAD" ] && [ -n "$$C_FUNC_TAIL" ]; then \
> >>> +             sed -i "$$C_FUNC_HEAD,$$C_FUNC_TAIL s/^/\/\//" "$$FILE_=
PATH"; \
> >>> +             echo "[INFO] Commented out lines $$C_FUNC_HEAD and $$C_=
FUNC_TAIL."; \
> >>> +     fi
> >>> +endef
> >>> +
> >>> +zynq_handoff_prepare:
> >>> +     @set -- $$(awk -F'"' ' \
> >>> +             /^CONFIG_SYS_VENDOR=3D/ {v=3D$$2} \
> >>> +             /^CONFIG_DEFAULT_DEVICE_TREE=3D/ {b=3D$$2} \
> >>> +             END {print v, b}' .config); \
> >>> +             VENDOR=3D$$1; \
> >>> +             BOARD=3D$$2; \
> >>> +             if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
> >>> +                     exit 0; \
> >>> +             fi; \
> >>> +             BOARD_DIR=3D$(srctree)/board/$$VENDOR/zynq/$$BOARD; \
> >>> +             if [ "$$HANDOFF_PATH" ]; then \
> >>> +                     echo "[INFO] Using manually specified handoff f=
older: $$HANDOFF_PATH"; \
> >>> +             else \
> >>> +                     HANDOFF_PATH=3D$$BOARD_DIR; \
> >>> +                     if [ ! -d "$$HANDOFF_PATH" ]; then \
> >>> +                             exit 0; \
> >>> +                     fi; \
> >>> +                     echo "[INFO] Try auto-detected handoff XSA: $$H=
ANDOFF_PATH"; \
> >>> +             fi; \
> >>> +             TEMP_DIR=3D$$(mktemp -dp "$$BOARD_DIR/"); \
> >>
> >> When you do out of tree compilation you very likely don't want any scr=
ipt to
> >> change your code under your hands.
> >
> > This script will on execute when XSA is not given next to the board
> > folder nor custom flag setup.
> > So it will simply exit and silently cont'd.
> > While the intention for this is run > make prepare phase.
> >
> >>
> >> I don't have issue with this idea to automate this but I see this more=
 like a
> >> tool not something what you want to run in every build. Please look be=
low.
> >>
> >>
> >>> +             trap 'rm -rf "$$TEMP_DIR"' EXIT; \
> >>> +             XSA_FILE=3D$$(ls $(srctree)/"$$HANDOFF_PATH"/*.xsa 2>/d=
ev/null | head -n 1); \
> >>> +             if [ -z "$$XSA_FILE" ]; then \
> >>> +                     exit 0; \
> >>> +             fi; \
> >>> +             echo "[INFO] XSA: $${XSA_FILE##*/}"; \
> >>> +             unzip -q -o "$$XSA_FILE" ps7_init_gpl.c -d "$$TEMP_DIR/=
"; \
> >>> +             if [ ! -f "$$TEMP_DIR/ps7_init_gpl.c" ]; then \
> >>> +                     echo "[WARM] XSA unzip unsuccessful."; \
> >>> +                     exit 0; \
> >>> +             fi; \
> >>> +                             if [ "$${HANDOFF_KEEP:-0}" !=3D "0" ]; =
then \
> >>> +                     echo "[INFO] Preserving old GPL files..."; \
> >>> +                     TIMESTAMP=3D$$(date +%Y%m%d_%H%M%S); \
> >>> +                     for f in "$$BOARD_DIR"/*.c; do \
> >>> +                             [ -e "$$f" ] || continue; \
> >>> +                             echo "[INFO] $$f -> $${f%.c}.c.handoff_=
backup.$$TIMESTAMP"; \
> >>> +                             mv "$$f" "$${f%.c}.c.handoff_backup.$$T=
IMESTAMP"; \
> >>> +                     done; \
> >>> +             else \
> >>> +                     echo "[INFO] Clean old GPL files..."; \
> >>> +                     if ls "$$BOARD_DIR"/*.c >/dev/null 2>&1; then \
> >>> +                             rm "$$BOARD_DIR"/*.c; \
> >>> +                             echo "[INFO] Removed old GPL file..."; =
\
> >>> +                     fi; \
> >>> +             fi; \
> >>> +             sed -i 's|#include "ps7_init_gpl.h"|#include <asm/arch/=
ps7_init_gpl.h>|g' "$$TEMP_DIR/ps7_init_gpl.c"; \
> >>> +             echo "[INFO] Masking GPL unused functions..."; \
> >>> +             FUNC_NAME=3D"ps7_config(unsigned"; \
> >>> +             $(call COMMENT_C_FUNC,$$FUNC_NAME,$$TEMP_DIR/ps7_init_g=
pl.c); \
> >>> +             sed -i 's/^ps7_debug(/ps7_debug(void/g' "$$TEMP_DIR/ps7=
_init_gpl.c"; \
> >>> +             sed -i 's/^ps7_post_config(/ps7_post_config(void/g' "$$=
TEMP_DIR/ps7_init_gpl.c"; \
> >>> +             sed -i 's/^ps7_init(/ps7_init(void/g' "$$TEMP_DIR/ps7_i=
nit_gpl.c"; \
> >>> +             sed -i "/For delay calculation using global timer/,\$$d=
" "$$TEMP_DIR/ps7_init_gpl.c"; \
> >>> +             sed -i "/int\nps7_config/,\$$d" "$$TEMP_DIR/ps7_init_gp=
l.c"; \
> >>
> >> This sounds very similar to
> >> tools/zynqmp_psu_init_minimize.sh
> >
> > I am not aware that Xilinx has this as I moved from socfpga and did
> > similar things.
>
> Welcome on board.

I don't think extra .sh is good for users to build u-boot as most
people run make {flags}.
Meantime dual to the leak of script like Altera Python handoff this
script is so messy on the ps7_init_gpl.c
But lucky I think there are almost no big changes on the export from
Vivado to XSA(ps7_init_gpl.c)
So the structure of ps7_init_gpl.c will be kept and the only part for
ps7_init_gpl.c is to mask some functions.

This is the best and cleanest way to start enabling users handoff from
XSA and minimizing the changes of current
u-boot files.

>
> >
> >>
> >> obviously you target Zynq and not ZynqMP but one part is extract it fo=
rm xsa and
> >> second about cleaning. And there are much more things to clean.
> >>
> >> You should divide it to two parts.
> >> 1. just unpacking xsa and installing it to certain configured board
> >
> > There are actually not installations at all as 2024 Vivado generated
> > XSA that cannot directly
> > extract and place w/o build fails.
>
> Sorry not following. By installing I meant simply unzip and copy that ps7=
_init*
> files to board folder.

NO, what I meant is that the current U-boot only uses "ps7_init_gpl.c"
inside the board folder, the only change is that
single file to change.

>
> >
> >> 2. ps7 cleanup
> >
> > The cleanup does have a flag for users to select keep or not.
>
> Which flag are you talking about?

Please see patch file top header section:
There are clear messages explaining the script operation and flag.

>
> >
> > TBH: I am also amazed by why Xilinx did not include XSA handoff flow
> > between upstream u-boot.
>
> Because SPL is not Xilinx official/supported boot flow. Only FSBL is.
>
> > I do understand that most of the users use the Petalinux build flow on
> > top of Yocto.
> > But this setup completely wastes a lot of computation power and complex=
 things.
> > I run this script and boot my board w/o any issue when simply passing
> > Vivado exported XSA.
>
> But they use only fsbl which is feature rich bootloader.

There are different ways I also tried so far you can use Vitis
fsbl.elf join with u-boot.elf.
And form boot.bin to boot.
Or
Simply both boot.bin + u-boot.img
However dts will be lost if fsbl combines.

The idea for this script is to completely take Vitis out of the story
and basically u-boot mainstream.
What Linux Kernel does and does itself job and vice versa on U-boot.
We don't need fsbl on u-boot SPL flow.

>
> >
> > Any feedback is Welcome =3D]
> >
> > FYI
> > I also noticed the board flag of the ZYNQ is kind of funny.
> > I had to use device-tree labels in this current script to make things
> > work normally.
> More details please.

I am linking Tom to confirm this as well.

>
> Thanks,
> Michal
>
>
>
