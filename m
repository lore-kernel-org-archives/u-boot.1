Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FFC606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pTeLmALz;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Txx/tcbS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 414A760AC9;
	Wed, 11 Nov 2026 08:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CdCaQt1y0j4K; Wed, 11 Nov 2026 08:37:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E25C6070C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794386267;
	b=GHXNKSBmtHLyUkHDo4HGdB0u2+pibKqJOdltuobhDiRzgKVdGlQccRyZCfjOpTzStZ9X
	 3evjvrWGhXXIfm6nuJUfAF60MpnYP16WD9LoHDCsJnIgpxAW4r9L08TGoBSp3fpbOoHx+
	 dqdl5cGEUCNKO6AWTINdEJCbpuHDtDQutT0p0+er7/P28JMODcURusw3x2fK0i5lGISIa
	 D76TrtuCDD9EYXrt0OdZl9oJc68fvI6esdeH3arQEiYQICB0kyjeZd6jGKeEZJHbBTz92
	 iNEtIHQB5oaQM42Lcctapw/pASsYxQoVh4epWPvgyYlNoIDKpHDyJNKUKCy940KW0bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794386267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/x9TbmJVLl1w/f8CEfIt0jBIZSklsYUPJ/Secf+oBZQ=;
	b=QyXVVQ+BEASSBH49uHWxOGZWGG3H/EUEwEe+hN8J5GcXGrWT0YKSi1SeBEkvtHpF/9AV
	 bPBOISKn/Q/eOyzQCI8SO8B8bpdFzgz8h8scbwFPdWitNN3/qTEI4hCy3DtUkzSYu42Nq
	 K45kEvTtxMfw2rxFWiERrD25zP2l7qkDiA6+YeVZ8XmEFDdnfGY3NssnAJam2Uq3HTznV
	 +gD/cj+E27Sz4G+VuABnr+rVF8Co9TH9ntBkWCKCrFLfe6j/c3blS56kQevSBNrizfnxB
	 aybec8ijUa60gnWu4aWu/Jz0fNXTv+qbwO8qonH/paoCIwxI+avpQjc6AzqaDaNffWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794386267;
	bh=/x9TbmJVLl1w/f8CEfIt0jBIZSklsYUPJ/Secf+oBZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pTeLmALzuX1fICNE3t3x98igQWtpGtjQHy+yjHAQEfBKg9CwZOH2Ql7lyMmwXYqVz
	 EHmKC7Nax96oZge/DDmBM1hRjFQzsSg+NJzo/GA9GtiAvA+soOS2MCZ/LqVjQfqUPB
	 46trzqqvOjYOIAsHdOI/o5vm/SV8IhZqdxmAL9sJb/x9EL96Ujf0n9tAQ0Emaz/klc
	 t+geeZLAitaMiVB1wF5z1AsZ/nOqPEZ9g/xnQDoOHIJ+HHgfCAbl8MueRgq+znajNt
	 foJ1tjQw4eFlEBqLFHPOoaORiFb1qkR7XKSK24lO2KWER1AZ4iJJr6nzm+dZSzZOLp
	 BXXTcm2/YfeKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E25C6070C;
	Wed, 11 Nov 2026 08:37:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93747DB4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 903FE81143
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3lqAngqKplfK for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:37:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6EA1A8113B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=briansune@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Txx/tcbS
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6EA1A8113B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:37:43 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-84e513877a3so2594176a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 00:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794386263; x=1794991063;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/x9TbmJVLl1w/f8CEfIt0jBIZSklsYUPJ/Secf+oBZQ=;
 b=Txx/tcbSD4AhhOGbDHXmxoE0BTzGxJ5kHPysZnroZygOW78HJqGsO7Y37ehqNLF3hN
 3xpLxmYxLSebj0SN1tia/ExEWuUdACZTTf7/ZGBmd1ce0Myn429eGmrVuSxAPlHY69+6
 62+O+IJSXRA1iNsAvOJsKZcbj3XG8EGnTHTArOLLw2DTUGKPQiSwiBNT9OGiWIDcqJyR
 8wMsx3q5ifng1vMAF1lTmoAI3BIltj//3MrvdPbnPMJxfPCumGGLpJeg8tzg/hVTATMf
 h45lzTatk2NLGWJzPUBVKjm6je5FreRPLCz02dJ7gwh03zzj/qs/IqLEaAniNYojpMZ0
 TEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794386263; x=1794991063;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/x9TbmJVLl1w/f8CEfIt0jBIZSklsYUPJ/Secf+oBZQ=;
 b=tbaIaPSFiZgQA8mqWO+JS5BwYRlscOQOXOEWFOs131U5gn8W1xTdQtM8TgwB0JKFv9
 HXJa53N8rAGqO0wswo214gBsoin+Yio486yvQ8Bf6qkIHDcUTIn3/2RqKW9sDJZncdYN
 r3PkyNacTxmvCTLYI9+w0LOI6A00Ftd2ik/BFuPueOYPthlPCGVV20NqWqUAsXS23e8x
 alxArgWh5B0t7cZr6nfcg0jH0mwS1o1UiZvFpD2xrKD1K5dJAwpN7J484+9Pq06LmHwQ
 c4Tlgc1nWbfp+6bu4FGENhWnZvnnv8Q/buZcRj8WwQgkdHIBvaCZF3lAzPGvFlQiZuWS
 1xPw==
X-Forwarded-Encrypted: i=1;
 AL+hErF72qdgSO4KqCbxMOgflUxZiaeZzvaRVCZBQU84hSoEy94c2zMVXEiS71tMyjFZlxgQ20r1wcw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8QIlYMSeweB94CWN0U9N14HpSxa9tZ+57h4tF/1R2il21mg3Iz
 jXL6zBKHZR3sWegptwB1o+HTfSPX2BWRW01hTsAEmhnUcBsnfVhra5EcwScyCzdBNfjb/sGSHtV
 C2Y7yt1fwDZzXmn7TcBRZ8i07RfhR04k=
X-Gm-Gg: AYBFou05vhE7ozV2SX8fQYYOVSGlWoduMfVmSbLzgaD6vq8lBlLCDjot7oaMw0wN0VC
 H4XvQ5p0n/BUOebDQD+eyn6pSghHOIb7t6j7jz13Kj0GSTP2er7G61PQxOdRoc/b86W09r/XZzX
 ms3RyoEVlEyTrtTbQxzGWbDQJ4jVnTDsQ+GUVE6/xb1uNzwzqW4j9LBULzsMybUmMyeRaju3eDr
 Lnl//YC3OB+96b4uSRf1Des18RFxjzd97/+J2h2BaoCRZvp8AnbrwgyT68J5N63qk9yh9pl0e3L
 Vnuse3ZVvbWyRqlNodbhl7n6W4QVGNkL99INuck+5JC3nhfMknsP8gVdJ8h6l+T6B64T/42BvLc
 2C3JzaGekGmSuNOtxuzrUKg4a3R9L3/iYA0K2dg==
X-Received: by 2002:a05:6830:2692:b0:855:4d49:10aa with SMTP id
 46e09a7af769-860f036a9dfmr1551775a34.24.1794386262768; Wed, 11 Nov 2026
 00:37:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111062128.215998-1-briansune@gmail.com>
 <7d5f0c9f-6f04-4773-a0f6-1cab069a2f77@amd.com>
In-Reply-To: <7d5f0c9f-6f04-4773-a0f6-1cab069a2f77@amd.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 11 Nov 2026 16:37:32 +0800
X-Gm-Features: AclHuK9rccP_cgvQES5C0_yUNIN6eGn4auSXcQb5sZmXH0I9zN_8t3kD9Yvig50
Message-ID: <CAN7C2SC+Xzh-MsgoS5zYq2piDajpLh8BzGTkBdzCQ396oLgEPg@mail.gmail.com>
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

On Wed, Nov 11, 2026 at 4:13=E2=80=AFPM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 11/11/26 07:21, Brian Sune wrote:
> > This patch adds XSA handoff for ZYNQ core modifications.
>
> Add XSA ...
>
> >
> > User now can place XSA file next to the board folder where auto
> > generated from Vivado build flow.
>
> What would be intended workflow?

The intended flow is any XSA changes from Vivado build:
i.e. changed MIO unused or EMIO rerouting etc you have to update the board
file ps7_init_gpl.c to ensure boot follows.

>
> >
> > Signed-off-by: Brian Sune <briansune@gmail.com>
> > ---
> >   arch/arm/mach-zynq/config.mk | 97 +++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 97 insertions(+)
> >   create mode 100644 arch/arm/mach-zynq/config.mk
> >
> > diff --git a/arch/arm/mach-zynq/config.mk b/arch/arm/mach-zynq/config.m=
k
> > new file mode 100644
> > index 00000000000..2680db85d25
> > --- /dev/null
> > +++ b/arch/arm/mach-zynq/config.mk
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Brian Sune <briansune@gmail.com>
> > +#
> > +# HANDOFF_PATH
> > +# ------------
> > +# Unset - Board path where ###.xsa locates and "ps7_init_gpl.c" should=
 be placed.
> > +# Set   - Custom path points to "###.xsa" file.
> > +#
> > +# HANDOFF_KEEP
> > +# ------------
> > +# Unset      - Clean ps7_init_gpl files.
> > +# Set        - HANDOFF_KEEP=3D , Clean ps7_init_gpl files.
> > +#      HANDOFF_KEEP=3D0, Clean ps7_init_gpl files.
> > +#      HANDOFF_KEEP=3D1, Backup header files and rename to "ps7_init_g=
pl.c.handoff_backup.<timestamp>".
> > +#
> > +# Version Log
> > +# -----------
> > +# Date - 2026/11
> > +# 1.0.0 - Initial Release XSA handoff for custom boards and existing b=
oards
> > +
> > +ifeq ($(CONFIG_ARCH_ZYNQ),y)
> > +archprepare: zynq_handoff_prepare
> > +endif
> > +
> > +define COMMENT_C_FUNC
> > +     FILE_PATH=3D"$(2)"; \
> > +     TEXT_MATCH=3D$$(printf '%s' "$(1)" | sed 's/(/\\(/g'); \
> > +     C_FUNC_HEAD=3D$$(awk "/$$TEXT_MATCH/ {{print NR; exit}}" "$$FILE_=
PATH"); \
> > +     if [ -n "$$C_FUNC_HEAD" ]; then \
> > +             C_FUNC_HEAD=3D$$((C_FUNC_HEAD - 1)); \
> > +             C_FUNC_TAIL=3D$$(awk -v start=3D"$$C_FUNC_HEAD" '/^\}/ {i=
f (NR > start) {print NR; exit}}' "$$FILE_PATH"); \
> > +     fi; \
> > +     if [ -n "$$C_FUNC_HEAD" ] && [ -n "$$C_FUNC_TAIL" ]; then \
> > +             sed -i "$$C_FUNC_HEAD,$$C_FUNC_TAIL s/^/\/\//" "$$FILE_PA=
TH"; \
> > +             echo "[INFO] Commented out lines $$C_FUNC_HEAD and $$C_FU=
NC_TAIL."; \
> > +     fi
> > +endef
> > +
> > +zynq_handoff_prepare:
> > +     @set -- $$(awk -F'"' ' \
> > +             /^CONFIG_SYS_VENDOR=3D/ {v=3D$$2} \
> > +             /^CONFIG_DEFAULT_DEVICE_TREE=3D/ {b=3D$$2} \
> > +             END {print v, b}' .config); \
> > +             VENDOR=3D$$1; \
> > +             BOARD=3D$$2; \
> > +             if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
> > +                     exit 0; \
> > +             fi; \
> > +             BOARD_DIR=3D$(srctree)/board/$$VENDOR/zynq/$$BOARD; \
> > +             if [ "$$HANDOFF_PATH" ]; then \
> > +                     echo "[INFO] Using manually specified handoff fol=
der: $$HANDOFF_PATH"; \
> > +             else \
> > +                     HANDOFF_PATH=3D$$BOARD_DIR; \
> > +                     if [ ! -d "$$HANDOFF_PATH" ]; then \
> > +                             exit 0; \
> > +                     fi; \
> > +                     echo "[INFO] Try auto-detected handoff XSA: $$HAN=
DOFF_PATH"; \
> > +             fi; \
> > +             TEMP_DIR=3D$$(mktemp -dp "$$BOARD_DIR/"); \
>
> When you do out of tree compilation you very likely don't want any script=
 to
> change your code under your hands.

This script will on execute when XSA is not given next to the board
folder nor custom flag setup.
So it will simply exit and silently cont'd.
While the intention for this is run > make prepare phase.

>
> I don't have issue with this idea to automate this but I see this more li=
ke a
> tool not something what you want to run in every build. Please look below=
.
>
>
> > +             trap 'rm -rf "$$TEMP_DIR"' EXIT; \
> > +             XSA_FILE=3D$$(ls $(srctree)/"$$HANDOFF_PATH"/*.xsa 2>/dev=
/null | head -n 1); \
> > +             if [ -z "$$XSA_FILE" ]; then \
> > +                     exit 0; \
> > +             fi; \
> > +             echo "[INFO] XSA: $${XSA_FILE##*/}"; \
> > +             unzip -q -o "$$XSA_FILE" ps7_init_gpl.c -d "$$TEMP_DIR/";=
 \
> > +             if [ ! -f "$$TEMP_DIR/ps7_init_gpl.c" ]; then \
> > +                     echo "[WARM] XSA unzip unsuccessful."; \
> > +                     exit 0; \
> > +             fi; \
> > +                             if [ "$${HANDOFF_KEEP:-0}" !=3D "0" ]; th=
en \
> > +                     echo "[INFO] Preserving old GPL files..."; \
> > +                     TIMESTAMP=3D$$(date +%Y%m%d_%H%M%S); \
> > +                     for f in "$$BOARD_DIR"/*.c; do \
> > +                             [ -e "$$f" ] || continue; \
> > +                             echo "[INFO] $$f -> $${f%.c}.c.handoff_ba=
ckup.$$TIMESTAMP"; \
> > +                             mv "$$f" "$${f%.c}.c.handoff_backup.$$TIM=
ESTAMP"; \
> > +                     done; \
> > +             else \
> > +                     echo "[INFO] Clean old GPL files..."; \
> > +                     if ls "$$BOARD_DIR"/*.c >/dev/null 2>&1; then \
> > +                             rm "$$BOARD_DIR"/*.c; \
> > +                             echo "[INFO] Removed old GPL file..."; \
> > +                     fi; \
> > +             fi; \
> > +             sed -i 's|#include "ps7_init_gpl.h"|#include <asm/arch/ps=
7_init_gpl.h>|g' "$$TEMP_DIR/ps7_init_gpl.c"; \
> > +             echo "[INFO] Masking GPL unused functions..."; \
> > +             FUNC_NAME=3D"ps7_config(unsigned"; \
> > +             $(call COMMENT_C_FUNC,$$FUNC_NAME,$$TEMP_DIR/ps7_init_gpl=
.c); \
> > +             sed -i 's/^ps7_debug(/ps7_debug(void/g' "$$TEMP_DIR/ps7_i=
nit_gpl.c"; \
> > +             sed -i 's/^ps7_post_config(/ps7_post_config(void/g' "$$TE=
MP_DIR/ps7_init_gpl.c"; \
> > +             sed -i 's/^ps7_init(/ps7_init(void/g' "$$TEMP_DIR/ps7_ini=
t_gpl.c"; \
> > +             sed -i "/For delay calculation using global timer/,\$$d" =
"$$TEMP_DIR/ps7_init_gpl.c"; \
> > +             sed -i "/int\nps7_config/,\$$d" "$$TEMP_DIR/ps7_init_gpl.=
c"; \
>
> This sounds very similar to
> tools/zynqmp_psu_init_minimize.sh

I am not aware that Xilinx has this as I moved from socfpga and did
similar things.

>
> obviously you target Zynq and not ZynqMP but one part is extract it form =
xsa and
> second about cleaning. And there are much more things to clean.
>
> You should divide it to two parts.
> 1. just unpacking xsa and installing it to certain configured board

There are actually not installations at all as 2024 Vivado generated
XSA that cannot directly
extract and place w/o build fails.

> 2. ps7 cleanup

The cleanup does have a flag for users to select keep or not.

TBH: I am also amazed by why Xilinx did not include XSA handoff flow
between upstream u-boot.
I do understand that most of the users use the Petalinux build flow on
top of Yocto.
But this setup completely wastes a lot of computation power and complex thi=
ngs.
I run this script and boot my board w/o any issue when simply passing
Vivado exported XSA.

Any feedback is Welcome =3D]

FYI
I also noticed the board flag of the ZYNQ is kind of funny.
I had to use device-tree labels in this current script to make things
work normally.

>
> Thanks,
> Michal
>
>
>
