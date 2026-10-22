Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59ED606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZHHsG/Z+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eEvYukpH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B028881401;
	Thu, 22 Oct 2026 19:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2MkxBCH9rURs; Thu, 22 Oct 2026 19:03:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BF861812E9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695784;
	b=fHnoivM3pnUD5GvxqDfCLk8xD4KDSfvT9bbJKHWcf3ubfhPbvilyrR1/+pRGJkeh84q4
	 FFAOA9rqeML+qgNmFLWnIWhaJePQPnBLiDFZ+OxbB6viRCkRBjd3Sbjtf82uYMrpcvjnx
	 8YA3VV5B0jHejj77gnITgOtZ17rPwlDi5On6R0T0XdjU+GvrJLvjZAyTkR0WejXRG6o4F
	 1Hpm3t7a/YKsBKAH8DRb3JopbLxziEmPzNlAgrVYLJtF8wctoP51W5ZB/vI9kRVR6V+8E
	 Nf9h3xc+n82dykqWCod5ewK/hFSUPrvgXFPraeETvFSK9Q6VfEb9JtOvdYd3UrMOwsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695784;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hMoxkB219bkOb3crZezCCNm/59XtIoloWsdSopRMntc=;
	b=shHU3UUweO2wljYXZRTgSywYELfhu6KqBZpT0U0wG+ETmbS8LaLDqohBFQjumI5Z5Y6W
	 TSQCBkqN6kFreqChDHBrlu06jUDG2Ki+9CHzJ198IoU7qJfP8XPvPUI9xPsozlOqT5yj8
	 WvBuw0qeDg+I7KtfWsHvgm5b+d5ccUecUYZ4OeAW3Pu7wdhwdht/iF7vD5Vf9/NX93ig6
	 ICeyvlLo0rEADs0ULYEBlSChcrqVPl1WrqQTgmtapvypEOy9yft7SpUCkUM+e55Abbh5c
	 BFY+86YV2lSQaaw818436+dOFR/JEpQNbWt548hUgPT/MIypmje/N95q/Vup8JK5L7A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695784;
	bh=hMoxkB219bkOb3crZezCCNm/59XtIoloWsdSopRMntc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZHHsG/Z+/76gpJA9NZh+UnnMUwgiMkgzwST/eXSb8VJWhdWGX2IE5DqeGQSuNOcG6
	 wbfGd9klfYjBCCdzhbDgJngwcnkNs6HX9XkS9PwfvGQaqrB73/T5hYQ8KGU47ARfDa
	 PsVaZFOq1iCIoLHKFesQ2KYNBJ42HpfZLDKYqcdTQSURbMlQVHoR8Al6f4cp2tdA2o
	 U/kUSDAjZV/Vk3d7VBadM4spd5wqpNGkF2X4Icd//+kK4MG4sPE8A60BkE/hks/ugm
	 W0fo8xxzvbm27zSCQT2YZVvOzQU3WzyNbembDhA3p66rtug5p9K3aNBZhkojsk348N
	 PcCm/X9sD+DDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF861812E9;
	Thu, 22 Oct 2026 19:03:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AF3F3A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1CF734098D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4EOW07guiyDH for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 411DC4099B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695772;
 b=Yi87LlAXdvFM9Nplv8skRz0jcwtBiN9USro0OR/4hZ7nVXx+qtPsACzS9yVom8HS0ZGo
 o+BzeSN7o1LnlXALb8/XoygddMmoakZ6/l9NGf0dXkHGdzCMlZ59D4lcGmLbdqdcsxaQ9
 /BnwM+30fvMnRuQQy86pWbNCF0MzVR1nhJddFTaykr6gXuD8uG/eTcRNyX/MsVfylu/g/
 Z1VvoTPI7+7Wq+oSgqfZrke7GyA1wV+Cty+nvL+eh336XjHlWc5QIHEtY3KBlxIBx2R7o
 AVlp9JstBZS7otzD/H4mTTDXGulfP+bEmrfhUg2YuzS2iFlDbKr5D58HllA35K+D4Xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695772;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=hMoxkB219bkOb3crZezCCNm/59XtIoloWsdSopRMntc=;
 b=WDLkFluM3HkucapFzdftVoFuG0sITmfaSvCLyGmXlD4UYNnbPSPmieMX3SNBvYeNRoNm
 B91uRJm3uI1loqGkfyUYLaeiX6fj2DmEpsZbsQSy0JA9LFxcfRYKG1fTpFVGg1YnNZ/oJ
 tDBuXJMBGgLItwpxbT3m5yhueTcnq5FPKXt80MScVR9RhbveRO6N2hPoLOcoat/SJ9iEZ
 yVS4AnNMRbr6Rfq7avvehodenZUMRZTQxB3Z1ohXl8cIjMeNY1nF0IoM4vfNBXQ5b1kMU
 Tm9fnXjDev4yfK9QY28zHQ7sP0Yvf/uxtgTEk8WW9LgjZ/LgSX7ugHJmMwosTlk+E1Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eEvYukpH; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=eEvYukpH
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 411DC4099B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:51 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso906813f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695770; x=1793300570;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hMoxkB219bkOb3crZezCCNm/59XtIoloWsdSopRMntc=;
 b=eEvYukpHh1og+1mYVGROUrnxd5VL8I4GUXBXiLazVkrQRyivWCsyIK1o493STyfcsn
 DtHOztbsm0+cmCNM/vsgT3Xi4wM8NXL0ikeuhlxMuX+UqHuM+3DJx5QfTlgPAtY04b8Q
 u6pvCDngVxMDEMD/QtDzMsOf/LbFZOcmvPrMTNdL5T8e6joFNeVNsU6tejsffRFQvIsQ
 /XIFliZWZVPvXwr4Xn3tXLeVS1PPdLKi9bb1HYPzNYq9mhNQ9YpoxLmOnmTfNkZ6hbJG
 150oHicnhTEz1SNZI1FNIhn/Q825kr57MfPf61spasByGNFh1RwPLm1V9uL4ADeL3NQx
 VOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695770; x=1793300570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hMoxkB219bkOb3crZezCCNm/59XtIoloWsdSopRMntc=;
 b=Wy45p0v/36YiX5XKmf6dw0eD5k9wgO6CfkZj6Ugtz2BLaAAmXcAJfo3M9+95ADXTIA
 Q5RYP0j24zFq8G4nbEUR6solY+xNwDx6AjsTAeIO99CD3pJtMhUPKzseRW2IBrpli3/l
 oxn5zb2sm0Rgqf1MIyKR8J/LwaHB7XW8OnidDTN1uTyxMKlpeAeag/X5Cw/8TDdrSP8x
 qzyp2BtB2fv1YROghfFGaH1bMSLorIHEwxXHmAsIbjdSsuCjpWZkLdnEnJ99DpWxLk50
 Xq3Eu+0buatTa5C6+g38szMNJ9wFgDmxCGqUQZ8KrMjjhBrDYcxpe2DJ5H9JRzkGXER1
 oekw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmGCoJhqQZgg1+ebItPVSnqopSqGsljB7S2eVn0tHJo0ZGF1hQxYyPhkAE9k1+GIyOQkj76Xk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIIOL9Z///wFIVuCw/rQzRMIg1P0m8iX0m82iz/XV4OmO9MvOT1
 BL4ibB/VkwUeYGkFMhK7ZStQ0NLMzn2hCS7QUCpqS3yHupnS9Qy7ESZd
X-Gm-Gg: AYBFou3jmDatKRJunvmfDr4k9uveh55j0wgyIneA8+dPKk5CHRPFvXp7NyUGroBm7oB
 M7yJ9t/d3MXhVaDuprULH9zJGHN+I9TS8SjAcj5zj0zJbJUOUKESqZa79VzWk1dZv1qOHFuwrsc
 UDkyFg47iLMwEldd8aQV2q9rsfLTp15LCrE/p8REHSIVRtqu7gBk6JKn8FYf9hnHIx1xwj3r1xk
 pu/8swnuzBwWmQTR4oDPFdVebTu9yjsMvEwVEpuZbi1LM0towb820siJys7SqovqEPTDy7ZRoHU
 c8m02fur9vGmT0Lc+nvTCN4Qajs6qFC2fFDTmulvlPkHoHNjzO1TrDgVg1eLlk0y86TdWNjt8yT
 /Va/eCEPZu4+0ZNIPO73PeTqT/yPdr9m411ceVHp+GCY3Y4TdCC6c2z0DVq8qU0d8lAEXRaSINE
 5oo3LwYzLj8+nQpulBGQerqkH9Hav8siO9TaixvDTxQttiKMh7AhP57ezNFfchbI7CnYag4pB18
 Ofp/O5+XbVShhFH9lNH5TS8x7SeGcl23kvTt5aYK844AismrB2w51tNFGAUxoB4A6a/50DGdYUO
 Z8SQOU2CRq21snNTLn0S1AlAQ6KRdOOBY6Qgg+38GyYUrmLL8k01s+AQ4tOg
X-Received: by 2002:a05:6000:4206:b0:48d:faa4:af9a with SMTP id
 ffacd0b85a97d-48e2d102ea3mr7148177f8f.9.1792695769801; 
 Thu, 22 Oct 2026 12:02:49 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 14/16] configs: an7583: enable PCS for Airoha AN7583
Date: Thu, 22 Oct 2026 21:01:56 +0200
Message-ID: <20261022190206.666950-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable PCS config for Airoha AN7583 SoC by default to enable
support fo External PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7583_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
index 7178f45e3f83..8b076c1cfe5c 100644
--- a/configs/an7583_evb_defconfig
+++ b/configs/an7583_evb_defconfig
@@ -65,6 +65,7 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
+CONFIG_PCS_AIROHA_AN7583=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-- 
2.55.0

