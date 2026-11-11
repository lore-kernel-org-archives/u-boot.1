Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3C606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OYRtiLfH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BpJiVuW/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68F4E811A6;
	Wed, 11 Nov 2026 09:54:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6b4z82ricdo4; Wed, 11 Nov 2026 09:54:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7CE088119D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794390849;
	b=f8f62lWF20pL++eiWwCSefBN5JL6IsL251BecE0k/H4gUMVahxBfJGD0/I7Ls7l9xF/h
	 tL4uxH/tOYy1Jys3lgI36MgXHV+vNBfyJE6FabevvV9JVgXX/F1l6RraYVZje0KOE17OG
	 eQh4sh6VsZfuJx8mAxCB5PFyZ4nmG+6CYpwwdajg/rrbB6sMAK683mbLSmexzHZdIxegS
	 6t9KVlfRqBii6rk7oMfyIeHY0Q85d7k7y7i6c3tQ06xAw8h/5TmI+TcBPVKVQKQVafla5
	 NSZW9Ew5OK/woZSSz1iRgwi9XXRUHrTTnxC8vdmk+RbPsfRvE8K5JBSZgLelQOzfoDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794390849;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=18xSCCB/Q+JkcS9ZsP6o4kKbNlu4WC9rEYbjO+vjQ6E=;
	b=Y1ItDvJE994HeuieIQVwB0OF2omGI0/cNTZOcMPJ+dR3LDye+QWH0IPvNYYu2/0iEbxw
	 uGSkPzhb1s4qTW/vvXCA01vZ6NKx3/Hx1tObtqcVt54c0NnAFNfUKWbJBOD0jvWKPy8wS
	 d82qghTKQuKdFkV26uEieeySpZcJKnJF4n1z52FLqLwLcy+JG/0rs7riq6QsJMj6osKwI
	 PDKBVysii6Qg+E4zLy9lUxv8/4uDey9SrP+D7ugpHHsf/uSG9i9GkcwzkImmLVJ6Gbvcz
	 b7ZuhL/GAC96YUWWu4TZnxZCLqi2s7JbxziqbMex29wyh20rpa/Bb983rQJgn8hEg2w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794390849;
	bh=18xSCCB/Q+JkcS9ZsP6o4kKbNlu4WC9rEYbjO+vjQ6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OYRtiLfHfeP7Ur+rE42XVon7Zei3luvjifRmL5W2kyYalxX8LjdLPhVYdNtgJhlKP
	 r6H26y+we63S+6VWw0HWAmHSobCzatNnfq9iGJ9/YiehNDm+YmUmxaYfx836W0QFy/
	 iT92DWzG9Cz9cGqOfUYtzeaKD38ak8or6VUeYMSHKevn1vHOm/BT9pCWRsj7B394YV
	 MJLmxuCdiJrXZlj5d437b/hJp9XwUZnNPTkgpQz/GmAmg+ZgXnbwajf0B5UzxwKu18
	 Z9vdGN3xH4FeA7uptSuCKAfTq1zjcTaMMjuhHbroo8EDG1PZomTShriIFjdaTrf33n
	 v8vVHqQkBlcXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CE088119D;
	Wed, 11 Nov 2026 09:54:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E92A117CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6B5140A55
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:54:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GO-oRufdwxBQ for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:54:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D2B7740A49
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=briansune@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BpJiVuW/
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2B7740A49
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:54:06 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so3063630a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794390845; x=1794995645;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=18xSCCB/Q+JkcS9ZsP6o4kKbNlu4WC9rEYbjO+vjQ6E=;
 b=BpJiVuW/WRxtUJ7SpxcEaCLnpBjMFx7Jm1JEOH+RjXomzT0HayeNX4LXL3SAfK/PxK
 dopgB6+yOdHPc+DrtB71+MK0K9ED0ZG62DBwjCZeDXinQPQF0sX235OK15J6hAVQ0G24
 38Q9Rhh4D07mTiuHhonp8smse94EUjZ0tIlOURtFkhXQlChxgsE7lyxk5KvvhP07DQna
 c66SIBFA47Clx7u+kAkQBYgDh2wYvi+zlEISId6LdCq6ybaDHnGZRbbIoVM1U7eIEviQ
 Uvdn8JFXl0dfChr+1QGg0wyrulxxBFcEICkSgdn/QJDUAb4DyPjRX0hVVKpjdOu0ZHO9
 1UJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794390845; x=1794995645;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=18xSCCB/Q+JkcS9ZsP6o4kKbNlu4WC9rEYbjO+vjQ6E=;
 b=fymV7ZW4ppwzah/6FIYkhcICaQPvfpJibzJ3ODPU3QKr9enI2iMYC2WryuDe+3JIUl
 ic2qjDIIZV9aJyhak4MdLPVPBrjssntOfan2+dwhi+ZkG495w7SXjaiA0KY5E/Vz6ADl
 rlcjJa5mlV0rkj9f6Cl7TAyoY+WhT6xNcixgW16O2m2xuVVNpYW0U5pP/M6w8RLnSEDN
 sWHkrFDQpAbOtbElRhLu1fCAgb1rcAkr8/qdRAyJnNRn8tpVAN3a7Fwt/xjUVZl18fwl
 NomI5z8p1+JQRrmzmJFgmJ9tMwakpIy1ep5muOyR4EPP5nFKZExTCuSUQnS6+ehTeQs7
 1dHw==
X-Gm-Message-State: APuU4Z+OYTGsqvwTQZ71IuKq/IIKctFE4SeDDR5T07SxjIyhdLN/Iv1Z
 Kmyy8JucjJBz3NHxisklkLIBMibOEBesB6ICkxmO2QWpi1qNyvdOvMxZ9qiPtZVFnJhT/XI6oOi
 +PRXDtQSCXojdFjfnHxEYu74BPCT6fVs=
X-Gm-Gg: AYBFou2izWvvjH+wYqNeiLBgX+DY5a2JDpLl/YYgufRN7JlvCc2YA4J7MQ1ehEXxlnf
 Uz8Os93m21kNIkxkrfgPc1EDYECh5Cayyh9mtgidMfjqyJ15DoxcVDmFZvl0jojJqE6bEp4js1z
 BaVuJ1AQ6tTUuAKyAqULSwvs3MYrvwyKAylFC0Hn96NXqInbyRm1sLxg9sRQhKaStZn77uczf08
 3duWW09GQ7jBYBRWtBiyPMomQPD/+0Hes04w3mRZa6DJimQM2U2phL1N51ai0w4yS7ndE4WRm/m
 /A4CgtZSQPS7AqfiAB5ys2ccNowqWjy+mpansw3fsQ3I6x9QGL+5/JKu6UkXIb9M9j/LbYTIDHQ
 TuxaTC8h6wJU4ztc6rwrxCLp/CO8BeD0trLlG3Q==
X-Received: by 2002:a05:6830:3482:b0:843:98dd:84e4 with SMTP id
 46e09a7af769-860f26032d1mr1582351a34.3.1794390845085; Wed, 11 Nov 2026
 01:54:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111062128.215998-1-briansune@gmail.com>
In-Reply-To: <20261111062128.215998-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 11 Nov 2026 17:53:53 +0800
X-Gm-Features: AclHuK84tYKvl2bSKyuoYHMT4VU2Zzg-zmo53Ke_OSNNPpTmOc1uMIbwYExAbKg
Message-ID: <CAN7C2SBWp82JHZXDHOEqzuk-u4nj-0hriZAvr6ANwDkKePSytw@mail.gmail.com>
Subject: Re: [PATCH v1] arm: zynq: Add missing handoff script to XSA flow
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
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

Hi Tom,

I would like to confirm some u-boot structure:
Each board should define a xxxxxx_defconfig?
CONFIG_SYS_ARCH=3D"arm"
CONFIG_SYS_CPU=3D"armv7"
CONFIG_SYS_SOC=3D"zynq"
CONFIG_SYS_VENDOR=3D"xilinx"
CONFIG_SYS_BOARD=3D"zynq"
For each board SYS_BOARD should be unique even if they shared some common f=
iles?
i.e. BOARD name should be zynq-xxxx where xxxx is some name and a
board folder with
the same name should be followed?

Thanks

On Wed, Nov 11, 2026 at 2:21=E2=80=AFPM Brian Sune <briansune@gmail.com> wr=
ote:
>
> This patch adds XSA handoff for ZYNQ core modifications.
>
> User now can place XSA file next to the board folder where auto
> generated from Vivado build flow.
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  arch/arm/mach-zynq/config.mk | 97 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 arch/arm/mach-zynq/config.mk
>
> diff --git a/arch/arm/mach-zynq/config.mk b/arch/arm/mach-zynq/config.mk
> new file mode 100644
> index 00000000000..2680db85d25
> --- /dev/null
> +++ b/arch/arm/mach-zynq/config.mk
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Brian Sune <briansune@gmail.com>
> +#
> +# HANDOFF_PATH
> +# ------------
> +# Unset - Board path where ###.xsa locates and "ps7_init_gpl.c" should b=
e placed.
> +# Set   - Custom path points to "###.xsa" file.
> +#
> +# HANDOFF_KEEP
> +# ------------
> +# Unset        - Clean ps7_init_gpl files.
> +# Set  - HANDOFF_KEEP=3D , Clean ps7_init_gpl files.
> +#        HANDOFF_KEEP=3D0, Clean ps7_init_gpl files.
> +#        HANDOFF_KEEP=3D1, Backup header files and rename to "ps7_init_g=
pl.c.handoff_backup.<timestamp>".
> +#
> +# Version Log
> +# -----------
> +# Date - 2026/11
> +# 1.0.0 - Initial Release XSA handoff for custom boards and existing boa=
rds
> +
> +ifeq ($(CONFIG_ARCH_ZYNQ),y)
> +archprepare: zynq_handoff_prepare
> +endif
> +
> +define COMMENT_C_FUNC
> +       FILE_PATH=3D"$(2)"; \
> +       TEXT_MATCH=3D$$(printf '%s' "$(1)" | sed 's/(/\\(/g'); \
> +       C_FUNC_HEAD=3D$$(awk "/$$TEXT_MATCH/ {{print NR; exit}}" "$$FILE_=
PATH"); \
> +       if [ -n "$$C_FUNC_HEAD" ]; then \
> +               C_FUNC_HEAD=3D$$((C_FUNC_HEAD - 1)); \
> +               C_FUNC_TAIL=3D$$(awk -v start=3D"$$C_FUNC_HEAD" '/^\}/ {i=
f (NR > start) {print NR; exit}}' "$$FILE_PATH"); \
> +       fi; \
> +       if [ -n "$$C_FUNC_HEAD" ] && [ -n "$$C_FUNC_TAIL" ]; then \
> +               sed -i "$$C_FUNC_HEAD,$$C_FUNC_TAIL s/^/\/\//" "$$FILE_PA=
TH"; \
> +               echo "[INFO] Commented out lines $$C_FUNC_HEAD and $$C_FU=
NC_TAIL."; \
> +       fi
> +endef
> +
> +zynq_handoff_prepare:
> +       @set -- $$(awk -F'"' ' \
> +               /^CONFIG_SYS_VENDOR=3D/ {v=3D$$2} \
> +               /^CONFIG_DEFAULT_DEVICE_TREE=3D/ {b=3D$$2} \
> +               END {print v, b}' .config); \
> +               VENDOR=3D$$1; \
> +               BOARD=3D$$2; \
> +               if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
> +                       exit 0; \
> +               fi; \
> +               BOARD_DIR=3D$(srctree)/board/$$VENDOR/zynq/$$BOARD; \
> +               if [ "$$HANDOFF_PATH" ]; then \
> +                       echo "[INFO] Using manually specified handoff fol=
der: $$HANDOFF_PATH"; \
> +               else \
> +                       HANDOFF_PATH=3D$$BOARD_DIR; \
> +                       if [ ! -d "$$HANDOFF_PATH" ]; then \
> +                               exit 0; \
> +                       fi; \
> +                       echo "[INFO] Try auto-detected handoff XSA: $$HAN=
DOFF_PATH"; \
> +               fi; \
> +               TEMP_DIR=3D$$(mktemp -dp "$$BOARD_DIR/"); \
> +               trap 'rm -rf "$$TEMP_DIR"' EXIT; \
> +               XSA_FILE=3D$$(ls $(srctree)/"$$HANDOFF_PATH"/*.xsa 2>/dev=
/null | head -n 1); \
> +               if [ -z "$$XSA_FILE" ]; then \
> +                       exit 0; \
> +               fi; \
> +               echo "[INFO] XSA: $${XSA_FILE##*/}"; \
> +               unzip -q -o "$$XSA_FILE" ps7_init_gpl.c -d "$$TEMP_DIR/";=
 \
> +               if [ ! -f "$$TEMP_DIR/ps7_init_gpl.c" ]; then \
> +                       echo "[WARM] XSA unzip unsuccessful."; \
> +                       exit 0; \
> +               fi; \
> +                               if [ "$${HANDOFF_KEEP:-0}" !=3D "0" ]; th=
en \
> +                       echo "[INFO] Preserving old GPL files..."; \
> +                       TIMESTAMP=3D$$(date +%Y%m%d_%H%M%S); \
> +                       for f in "$$BOARD_DIR"/*.c; do \
> +                               [ -e "$$f" ] || continue; \
> +                               echo "[INFO] $$f -> $${f%.c}.c.handoff_ba=
ckup.$$TIMESTAMP"; \
> +                               mv "$$f" "$${f%.c}.c.handoff_backup.$$TIM=
ESTAMP"; \
> +                       done; \
> +               else \
> +                       echo "[INFO] Clean old GPL files..."; \
> +                       if ls "$$BOARD_DIR"/*.c >/dev/null 2>&1; then \
> +                               rm "$$BOARD_DIR"/*.c; \
> +                               echo "[INFO] Removed old GPL file..."; \
> +                       fi; \
> +               fi; \
> +               sed -i 's|#include "ps7_init_gpl.h"|#include <asm/arch/ps=
7_init_gpl.h>|g' "$$TEMP_DIR/ps7_init_gpl.c"; \
> +               echo "[INFO] Masking GPL unused functions..."; \
> +               FUNC_NAME=3D"ps7_config(unsigned"; \
> +               $(call COMMENT_C_FUNC,$$FUNC_NAME,$$TEMP_DIR/ps7_init_gpl=
.c); \
> +               sed -i 's/^ps7_debug(/ps7_debug(void/g' "$$TEMP_DIR/ps7_i=
nit_gpl.c"; \
> +               sed -i 's/^ps7_post_config(/ps7_post_config(void/g' "$$TE=
MP_DIR/ps7_init_gpl.c"; \
> +               sed -i 's/^ps7_init(/ps7_init(void/g' "$$TEMP_DIR/ps7_ini=
t_gpl.c"; \
> +               sed -i "/For delay calculation using global timer/,\$$d" =
"$$TEMP_DIR/ps7_init_gpl.c"; \
> +               sed -i "/int\nps7_config/,\$$d" "$$TEMP_DIR/ps7_init_gpl.=
c"; \
> +               mv "$$TEMP_DIR"/*.c "$$BOARD_DIR"; \
> +               echo "[INFO] Moved new GPL file.";
> --
> 2.34.1
>
