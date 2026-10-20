Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95412606A324
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D2+1SwmQ;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=gjsec8bn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7091B40A12;
	Tue, 20 Oct 2026 17:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id keWWZX2ceEqY; Tue, 20 Oct 2026 17:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 27185409C6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517202;
	b=NIqj1AkSNrRfqIjpp0pcQ9uhf5tN1ZrDtvGbhxt/kuhMedUKsfP5/BjMHfFA2XQOsv5z
	 /oaWMJ72pUMWLz9B2nmxZLllyZ+72IR2iRFotEzfFuMZbiTvHW9BStqvAxeTITlI+SSh+
	 kPLwhtGZsN77I8/ksahckdbGQjj2jBzdt3kciLQpN0EjMpy4SGtzMHn99DJS7NzpfzW4S
	 kkYveAaPKjCECxvoeyPI6Va8OT0srq8xB07Bk2PEJyH0jjBGZgD0bfth1BqHqAmLK4dwN
	 ZrQ7SdRIgREZYi+aY+d7lsVC94TeBacMqreP6sbxQDGICtz8QDoEASZHRK8oNnau9DQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517202;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iw9aOp3XELYR8A+hn3xOXY7+sdn4OLDjU7cq86uhMU8=;
	b=nmMtmDkMI3D8a3db54+7FUSfjZvBk+jietic/nMvzG7dhN7i/9V27koBT0+M80H33it6
	 9tYqePUN26b1tCDy+QksK5N5wtd+eeZLUoQmtS9ae+mfzVYc4/JygXXkGL1uu+iEdToT4
	 Nkv1ntplRSmzZkv7cKjBLVcFwpIjfhkZjWqSfW6y6QatyR2VCU5JIV0vA496kb+M1dMDa
	 5Wima6xcElVnfbDBiKpasxFitF1JQhlrqcrBuOzyb/ovpuO6prWiqBfbMqRkOxvot7Pa4
	 MrBiC9wToB0vRA+8cyZwC+XvvTFN+J3+7T7H21IO/LvtPN/uENCviXjlWIsrfRW2SnA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517202;
	bh=iw9aOp3XELYR8A+hn3xOXY7+sdn4OLDjU7cq86uhMU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D2+1SwmQSsFIDxZBqGmgnbvyf3+ISGlxk6AsO3HFgLK+mcl+2BU4wNQx/rxgUnOR2
	 RiG3/G/TRtaQjX0LIO11xZ7xqoBfutZlyjNj8v1T/f537F6OF1hF8B7D/djihj7vle
	 xCoJ/+yAG8LkY5imn1sW0ZTRrm0WhK2CXgGhwGNWeOvw9r0oRfc0MiVmfte+uyCYqT
	 iah9gwkU4wQZkl6CNiu3MxSZ1qzG7KD5ByZKIu9DOL4KPueeyyps/uD514sXKlfmWu
	 BQZqyzOW0BR2W+a7qGPmWYC7kk/cw01Dic6QQ3tbCfQYLW0Um1y9U+oCTDS5aL1k19
	 ix9JpJgY8dhVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27185409C6;
	Tue, 20 Oct 2026 17:26:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42C89930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34374605EA
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qMmFkOfhAOot for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:43:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 15AF06071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514623;
 b=oXI2XOTRbq2bDMPJ+02NYGgkphcfDVC71vkztak2e2Q5SoLgje2WX9ucDywG54Fec1aU
 zftsnPxMlBFybkE/cJLkaQDB1M/ikJrXCT0I2n2v+MQlI0bte9Jwpl8P1IrXv3Ovphi40
 3sIEIXohGH1LeDgWZGgoFfqip5dKWXEb4RKhxVo2+jF3A2TMPEfeFJwNzJbScKXz17Iv4
 SL2Fit47sRsf3ip4KTesHKITS6RHpcVWsF1sspuc7N8QGGtf9ML69sHIVEP5HxlZy8lBF
 aK264+dbWW7SLmT1PL9LP7EpqxLDgxP45W4MjJU5wseB+v/iwY8m4zWSynddrKv4UXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514623;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=iw9aOp3XELYR8A+hn3xOXY7+sdn4OLDjU7cq86uhMU8=;
 b=Eke1SvEaBYBpqkltI6ZcXFd1mD4oXYG5YDCaakUstw4p86LxcaKBPtTrdGM5JEKeDNhZ
 XF9DerIHVEXQnjlBOwjgalqhBNyv5oZ1I3avRMY5q93MCBBHWtxtt/Jn2/dErEwxuJtGe
 tBU8g/Mvo2xJ/qXRNu4RXrf9DzG7w4/YYD8lZgZhNzmPeNiGOGvm1CWabbfLOFQc4Vgc+
 R7G7eEPMETWVnQnnB4KMQPyPoQ+bW7Dh2nsgMKkRFJ881S+7FhJIEnRShGHgx/3avgSXV
 NX4gXRJJcpfvGyPIBTM8YxGhg78HH5yYTluHD2/5Z8UN9Pp4iqH72LQwHDCkG8Vyr5g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=gjsec8bn; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=gjsec8bn
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15AF06071D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:42 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so29906575e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514620; x=1793119420;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iw9aOp3XELYR8A+hn3xOXY7+sdn4OLDjU7cq86uhMU8=;
 b=gjsec8bnCho10k3qDZJ4NwWV9GZbWewrboG1grCYnCS/G3myC/PDEOY03Vr+9BhxS+
 qYz2XgG/sWt/NI0cj25lEoT376Fr3f3gKe1epHZQKrnvpmy8plCTzqi4lBg0amNNEV0D
 cuuzNxI6kXv6Bylq4Y/lxyixXpO0q/ghcUiT/19EuDm9sbxOeNuX9/FjMQWh+b62O13Z
 cW0bUGrB69TbclBJN7U/w/gmVnRVgXykO0uRRxD+DMHuEI8T1bE0xP91FckY+VQpb9X3
 2NvZNcn+RvHVM/l1Md+l1kFv6CabyRsPGJSyfHLNB4yx1IJ0DhhJbRJE5gT3DT8xTsfs
 hrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514620; x=1793119420;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iw9aOp3XELYR8A+hn3xOXY7+sdn4OLDjU7cq86uhMU8=;
 b=1TNS1FwVhDMatP2TaKyOc1Kk4yV9sHwwp6Oe9KQGnfQLnEwqRAjzHt6D/t/pfS+8B1
 L4W1roHiAdhKV3FOs7vbcL78IXKWKZHRyvW4qDD0ICCHQSUEMNZuuWPxJqgrSpNKb2T8
 zVYeOHIwLUFhxVi7RC9gLr1jtQWQfeU7ovJVDcuV6HRCV+qm1Xu5bM8Icwpaz1IlQoE4
 Ye8L3/qjwMqMCN5LXUXJreIw2Mjon9FJxrnZuP2yxDYoUYKTRfz/VkmTAIGTLy8jFxpn
 +8tYfhhjC1aMnHDpdPqCZYtftm8PectoY3IldSuAlEMrT+XVuRV4YJ79MLZvBAxVkzfx
 uD0Q==
X-Gm-Message-State: AFq9FYKLS4Y04lN1syPwatBmzNTqzGRpmduHDQbifZcH0Lc1KZ1aypv3
 fts8RbR6izM8aZkw9TtXsoqW4qhwP2fNg2nAZa1wyntm11lEEWGZEmTa63xc9V4zw/w=
X-Gm-Gg: AYBFou1Jeb/RlRBO+B3Z+p+8xFkZacHOv5VhOXz2EbunwhiZ82bFEaJxHCbTTlCpRpW
 1xXwSkecVFm+phIU7g0C2fqVUhfu96foGu4vDtK9yVrhW7QS2qVAak51qy20rVVN1u8A7YzSCZm
 FCG/Imd/xM8a274iEI8uDPJELzv8T6SMalCHNZGjk6p9aGtm9vMvl0WZVVKQe+wu2PdCBFDMN73
 O/D/VipXp4icqL6tMYJORrOvHJryjBisHU4OGvyXFh8kLQF0WCxNPA9xt0jbx9Eq8EFK4h3djP2
 uU28yjMJk4HS9rE0NxMVwlocyRLyj7apZCloaeYeN5rreLD4eHaZhl9K5+RYqXg7Vp8PKYH2nkM
 wS0XWWUjj3o5Vs6Pv3MM8AWIichM/UVJF75BbMvLkZZT4t2l0mdOn+Xw+5LQKii3gXiJHAyusXM
 Hgj8PqvQP5C19LSEXnXC6LdobjWsOW0CYZAi3F8V7b1AS4D2n3PF8hkhQY/YSlTbsAGF2egi/rJ
 1QdmHZwHlx0HCzc7D3iw0dw74WsmsfhrOl3whgIGlrdmvBA5PGQMK8Z2tmF/2Jy
X-Received: by 2002:a05:600c:a088:b0:4a1:cd83:b23e with SMTP id
 5b1f17b1804b1-4a1d74644a8mr288662585e9.0.1792514620508; 
 Tue, 20 Oct 2026 09:43:40 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:43:40 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:41:10 +0400
Subject: [PATCH v3 23/23] doc: spl: Describe compressing the U-Boot payload
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-23-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
In-Reply-To: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4930; i=alchark@flipper.net;
 h=from:subject:message-id; bh=B85gnUBJ44bvEdZZl7GF1ppN+c6nzpOX6T5uJKimAYE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7n6odTL0w21IYuu/lePt445yLAo6mL0GrcnfX/uv
 vtW2mO2tWMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICplmNhZLitO5Pv7449CtOkGpxNprB4ivtdOWyZfZ2ppLRt684fzmsZ/mcsDih
 +0b51nmxZo5G3xUXviMksvXIpFle+3eh9Glx5lgsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kconfig help has room for what a symbol does, not for the reasoning behind
reaching for it. Describe the trade-off compression makes, what separates
the algorithms, and the addressing constraint that decides whether it works
on a given board at all, so the help text can stay to the point.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 doc/develop/spl.rst | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index 08b51172014b..88a325ed6ae3 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -151,6 +151,80 @@ NOTE: U-Boot migrated to a new schema for the u-boot,dm-* tags in 2023. Please
 update to use the new bootph-* tags as described in the
 doc/device-tree-bindings/bootph.yaml binding file.
 
+Compressing the U-Boot payload
+------------------------------
+
+Where SPL loads U-Boot proper from a FIT, that payload may be stored
+compressed. SPL unpacks it on the way to its load address, so the image on
+the boot medium gets smaller at the cost of a decompression step.
+
+CONFIG_SPL_FIT_UBOOT_COMP names the algorithm, and
+CONFIG_SPL_FIT_UBOOT_COMP_LEVEL how hard to compress, numbered the way the
+chosen algorithm's own tool numbers it. A level of 0 passes none, leaving the
+choice to binman, which uses the tool's own default except for lz4, where it
+passes 5. Both are only offered on platforms
+which select CONFIG_HAVE_SPL_FIT_COMPRESSION, declaring that whatever builds
+their FIT honours them: binman for every in-tree user today, though nothing
+in the mechanism requires that. Elsewhere the choice is hidden and
+CONFIG_SPL_FIT_UBOOT_COMP reads "none", so an image description may reference
+it unconditionally.
+
+Whether compression is worth it
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Compressing always buys room on the boot medium. Whether it also buys boot
+time depends on how fast that medium reads against how fast the SoC unpacks:
+the image is read quicker, and then has to be decompressed. On a slow medium
+the read dominates and compression wins; on a fast one it can easily lose.
+Both numbers are board-specific, so measure them rather than assuming either
+way.
+
+The algorithms differ mostly in where they sit on that trade-off:
+
+* `gzip`: a middling ratio, quick to unpack, and its decompressor needs less
+  of the SPL heap than zstd does, for its state and possibly a 32 kB window.
+* `lzma`: the best ratio on offer, and by far the slowest to unpack. It
+  takes no compression level; its tool is steered by dictionary size and
+  context bits instead.
+* `lzo`: a poor ratio in exchange for fast decompression.
+* `lz4`: the fastest to unpack and the worst ratio, suiting a fast boot
+  medium.
+* `zstd`: close to the lzma ratio for a fraction of the time, but its
+  decompressor needs the most SPL heap: a workspace on the order of 100 kB.
+  Kconfig cannot check that the heap is large enough, as it may come from
+  CONFIG_SPL_SYS_MALLOC_F_LEN, CONFIG_SPL_SYS_MALLOC_SIZE or
+  CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN depending on the board, so check it
+  before enabling zstd. A heap too small for it is reported as a failure to
+  allocate the workspace.
+
+Decompression speed is also sensitive to the build: a decompressor compiled
+to avoid unaligned loads, as xPL code often must be, can run several times
+slower than the same code without that restriction.
+
+Where the compressed data is staged
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+With external data, the usual layout for a FIT which SPL loads, SPL reads the
+compressed payload into CONFIG_SYS_LOAD_ADDR and decompresses from there to
+the load address the FIT gives for the image. With embedded data, it
+decompresses straight out of the FIT where it was loaded, so the same applies
+to the FIT's own location instead.
+
+Either way, the input must not reach into the output: the decompressed image
+is normally the larger of the two, so the output can overrun input yet to be
+read, and decompression then fails or, with an algorithm which keeps no
+checksum of its output, produces a corrupt image without noticing. The image's
+hash only covers the compressed data, so SPL checks the layout itself and
+refuses to load the image, naming both addresses: before decompressing,
+against as much of the output as the input is long, and after, against the
+whole of it. This is conservative, as input sitting just above the output can
+survive if the output grows by less than the gap between them, but no layout
+is meant to rely on that.
+
+A board whose CONFIG_SYS_LOAD_ADDR sits just above or just below
+CONFIG_TEXT_BASE therefore needs that address moved clear of the unpacked image
+before compression can be used, allowing for the image growing over time.
+
 Debugging
 ---------
 

-- 
2.55.0

