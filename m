Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEC3C982D9
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F176860D4E;
	Fri, 18 Sep 2026 10:53:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9a5vC_wLUDj3; Fri, 18 Sep 2026 10:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4B2FB60D62
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728812;
	b=erpLEbA118mdniQ42fmBHybrSUFc4mgxisJStZqE7BqwBk3vnzn6LlFTTikZef+L7k+i
	 pa2nAw9/6Ez1PNTAY0NlWpLHJDVLyYIsVda5FRH1qUiOZqMf4PKCw2D/Q/IwEpqYjfc4f
	 HrBl8ulAaXSI6Y4o4TvHjm59OJchDrzrZeEB/1G7+uThgP6lgGc9c8Dq2glrNCFMO6oZz
	 ZfSvrLmxRizHvicuXqL+LLWVFEXbxsgNnQsJsK6v83h3A5DdMKZN3RALiVYqQxaCkg8dw
	 N9H2pYXxDDpORBnC7GyJLP75qERm5Af9mmhx631Bqroh1+uxlu4ubUiEFTys5Acq53Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/Vcr59Cf8dP5Quj1LmEfLGbpf9ReZlAKoHPm0ma9AEc=;
	b=FaWhpJxgPVq31A7MW1gB/fyyg/XmKjTHV3y3l+rp1AB8HkBn5bbITFRo22+02gHFAAtS
	 m9vazdoUOaOsRGKDhI5kwQRZQgDef2sF6PJvNIyRyl1j3PgODgkjitJWm4gQUXwcem5HQ
	 /o0oO4w39FzUn9mB7xvWrcQYycNUhWJKBO/TzhjZQNa/AIAgoX94ntYyh+EyHzNuCBfSl
	 YyJlMJHyS77lnAiulVOiiG4GirQGFl0W/mta4iWw4st6fhEuqPPWCS/g7CDCuHC6l2mdI
	 SdJdA4zt3y3JmI/k2hhHAtpfQThJmm+AeKDslb8ai+hUe3wygh3+svJKlF4i+lWm8rg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728812;
	bh=/Vcr59Cf8dP5Quj1LmEfLGbpf9ReZlAKoHPm0ma9AEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dn/NRMT13dDdFxBweS2JsO1DXAJpfndPv0vfc2dixn5afqVZiZd5QTe5RF64ou3Kk
	 7Y5jDtiHqFcvdihn4Z+qC1FwNMisLXJbZy/UBDp4Nt68sDe7wCYFODzwy4Bds+Qje1
	 cb9TXKl2NZ0LYwCl2nmtKCxbRw1Gfj96g8ilFQ8pRclL9WmFboYvjtfw+QK7saXzMC
	 GlYiZgOL7o9ZVmi1FmjkYH0E5dDXFC8d2EJksoUDOQoatQfFMDjO3xEuPOLJpOvFl3
	 wCJhg5x2xRNSe58Og1qwhc9wtCzPFQIQfPK0/5GDYhQfnwFlTyc6ntZP26mukDWKXF
	 V6sXN1k2QnJQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B2FB60D62;
	Fri, 18 Sep 2026 10:53:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A330279
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B01C81295
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wWpc72rgmb18 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:53:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 77B378127E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728807;
 b=G2HI+5mT0VnsvmlTfmp5Ni7dVTdMkQSm8LOC2vK2XTFT9tLpG2xNh1+clRwHJirhdlSe
 VQSf0vJCe4RViui6EDGlEnwiSqrviuFb21VVK4frJDHS+JjhSQYJhh5FcdKkwD5XLU1EB
 L84N2fexs/5YjgY6PZzRs0FH1SSR64TKy+TXRjT9VykjB84Ri5uj8OCGvFSGdLO3XrRF5
 TS+oa88Qli1xRb/+KT4cyzDeBXF39pIQNJoQn0HMXPsBtex0rgEcZKzF+1Kv3eV6vsmx+
 qELNmfzq8jvIo1kC9OdkvzGueA6O0HZssgrpv3ARQAngm7KVOanXcG3UIoxLMOL90gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728807;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=/Vcr59Cf8dP5Quj1LmEfLGbpf9ReZlAKoHPm0ma9AEc=;
 b=mMzOP3s6EYbHTXAfBC2tH4T6klfORmiCnSZm5Z3aTQv5c529Dd02mK0mrMP3XAiGYi8P
 ZVBVW1UO7rs46uSK+DhwoVd9ByFuXFo1eqzkpqNEuG0xbW66+AIcrtj+jODTzBB5xOXaS
 OmXouyM+GkYNSLuygsTCGw7U112og4uh+0XkL3/dT+pt1Q9rM0kle+V2hWqg2eUG5XSZt
 +kDeTKQ7TS/H0wnusxWxBqf230mE1PldBDdz3dDzOoAfXDJfxlJHjt32DaIhumB5iX+r3
 YNH5858OUSNg9jMEn6eQis8sOR4TRtTcMqg/JvWpcMlP5k/CU9dKp7ZZIpr2eVn5YYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=BSeEskdj; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=BSeEskdj
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77B378127E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:27 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so5168755e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728805; x=1790333605;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Vcr59Cf8dP5Quj1LmEfLGbpf9ReZlAKoHPm0ma9AEc=;
 b=BSeEskdj23mXice4f+UrpMBr2f2OUrheS0ZO/dy00FxBypd2J13kAfA12vokSZiYjb
 scQHwFu2GGMztYFs55CEP12rrHHQS1fvKv0uznZzf7efZ6Y7EWFUWv+ldszPQw0sLOCt
 q/WakzlDBWkp6vJznj2LFV5bC58kFg8UL+DujWhi7oBXQcfCqtfBLgCVm1WY/9zp8n/q
 +v0Vd541xlgel1IB7iBAqHzwGAU2V41I5SvNV5mdOF3pQ9ugDQuk3rDXiG+AVcmN9JYr
 8iD/Y3W9uqZj4mf8r/Iqw9qYp4Kt9ptPKLYUDycYXjyezgjD1trCw9/UR/eKdpdlmG8i
 a+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728805; x=1790333605;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Vcr59Cf8dP5Quj1LmEfLGbpf9ReZlAKoHPm0ma9AEc=;
 b=jdwU4UqYi9rgWpm/Kj3O5lbMqPOdjfvQx83ExHf6/c6HrTtLgm1yqGwYDGKNzXh5Sx
 d2Durk8cchYijeRq+65djDRnPgttbv74mjA4tWLQp/p9FYj6ImN3RatbYWRGYCaivhuB
 z5iIhLjkF/7s5fJMFI5o+9V+z/SvGWIPkn510jvBtj+yNqYwodx24wpS2eeuTeGpflpT
 Ikjk8SbL5K5Z68ClY2UWldqyPynSI8zYYtJZuWhdIN8FUtM8duQqef3w0NHh4xRYgLWn
 EwOn1vaJ3I6dPToe3vma9EnhYuhscA0DiM1jtWivyK+cQ72Ad/Ul3ejvNlbPvS62zXDl
 ztYA==
X-Gm-Message-State: AFuF++nKqay+PA/aoitvkPaJywDqlbxeS0GHYWexa8RzB2DoaXtIjpzB
 PUEvBdH446yDzHZfm+wMTfxHkjOPhluaxx8CEnEJSriQpF4m5MNYIt5qzFOD7nO9Y3A=
X-Gm-Gg: AYBFou2AgVAkNEoxT7Z9hyimhK69AfIofsUkata1Pp1sbZJ3RI93CGMna+5biX6ZAcM
 cV6lSu/GlgIfRrn+PWKWtzfVkpxoicUxX6p90AGGIN+K9o0f8ssu3cSvVq1E+r9vLn2fVQrEvRD
 LB/9/Rlfjpf6I7vlqijJvgP2+3prjf//9lcqZ565XpGGUsWASTyT9UJc00oSLb/MUiFR0HqDbMr
 JBJVBuqSpkjmh39YWCB1BpfTgHSmuqhVyAEmO6lkYqqQqbqQD2EhynMqWHRLXfppWYHj+W18Iv9
 Zq+r3RnHs3/g38gt+oOf/Gkz8jZfYIuFIfSozLAEs+h8dpoEj9il2YsEKT6VeoN+riA8kdvFIij
 hGiXI402Kb8zfNj6V1elcS8xAgWwzNnx+oKes1jKV1f1GIk6tBw0idU2dMiRZZR2Z2+/f7YFcVr
 ZMV1Umn2FFXTewYO/H4X0UoCgvt8uN97cVQSjmzXtV/wWcbzhVNCuRuy3YiPoUEAQfkmrKj2PZU
 k0UBwQ2BKXoCqE98POxemiiBWww3ZN2DIlYWu/CNnM221/iVhTc1KoNGfpBPvI=
X-Received: by 2002:a05:600c:1989:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49fc5673292mr28100845e9.7.1789728805307; 
 Fri, 18 Sep 2026 03:53:25 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:53:25 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 14:52:36 +0400
Subject: [PATCH v2 09/11] sandbox: spl: Enable zstd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spl-fit-compression-v2-9-28e946f57357@flipper.net>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=688; i=alchark@flipper.net;
 h=from:subject:message-id; bh=sDUqwK+w6nEsd1ey+CV80G3RQLE2J+Uwfzuh2f9qZAo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf83P9lKYNr+eu3kZyFCAslbVRfudEl09nnfmbJLP
 e2X38HEjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKZ6bi0jw9mpuklXygsTu28aTl+mpOn+bLkP7zzf7bdk00rXcD3b1sbwP/10tD9
 D4tvY/zPnT3rr9v7Bo/dfs0TsG8T1eo4fe7lqLTMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Nothing in the tree had SPL_ZSTD set, so nothing noticed that it could
not link. Turn it on where the SPL FIT loader is exercised, so a build
says so next time.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/sandbox_spl_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index bec02ce7bb1b..135edd41835c 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -230,6 +230,7 @@ CONFIG_RSA_VERIFY_WITH_PKEY=y
 CONFIG_TPM=y
 CONFIG_ZSTD=y
 CONFIG_SPL_LZMA=y
+CONFIG_SPL_ZSTD=y
 CONFIG_ERRNO_STR=y
 CONFIG_SPL_HEXDUMP=y
 CONFIG_SPL_LMB=y

-- 
2.55.0

