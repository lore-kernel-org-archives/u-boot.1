Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD61C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 15:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21CB260726;
	Wed,  2 Sep 2026 15:56:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UiY_oZu5-egz; Wed,  2 Sep 2026 15:56:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788364576;
	bh=zOKkkiTvOdmoM+2yy6WrXS5hmm6h81JI5BLfIKCoGpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HDxsmtjvn2OJLbs5jIYzL/f66uB99YqGDdq7WcJQsv0Q6CKn5ouvwgu+V52OnqgGJ
	 nGq2huH7bA/Q6968vSzefZR43nIaP15bienvBTGwMtPmAe6W2n7Re4OZC5FreCPMmw
	 duqGGFPJ+yj4CJGXQZ1G3bJRq/2DVegGc1rgzeWLcpdphkznsjrNe2ywW2+pQ/jRlu
	 RI9ZZf/6T+9lpHZAg/UWiWg+Z4PACx7nrWvmgehbIpNJHJky2R7Uck8Ias7C176zAW
	 p1gOTK3b5jlcuEXXVQaU+tdFPzqf/r8udPrMD9/TJGryj+s8BSDi1S9q+w2078Pxmj
	 +wxJFtPwudXSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAD9C606C4;
	Wed,  2 Sep 2026 15:56:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ACBA22B2
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92A1840099
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W0vDKYKpjsLr for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 15:56:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JFXu6x/g
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B7D840096
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 15:56:13 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e9ef94c0e2so571441a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788364572; x=1788969372;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zOKkkiTvOdmoM+2yy6WrXS5hmm6h81JI5BLfIKCoGpM=;
 b=JFXu6x/gsuHUwesKMcnB4jArRomjsLwwM6eof588lQGTdaE/KL+/HrdI1ab40XY+T0
 FOH7zv+ntgZsS85bJ9kZj4gUFdJTTQwoGeEqLUXdoY/9JAP68QWXgsQg9EHStXsx2IXA
 IklRRQVNlQprhhuhFjtQ0Kc5Wa2Cows9sMCOrlFw4Si6qtwm70Hs/A9af9mt9HaZ13yZ
 kmdrC9gC1rU1lSMP/eMA0sLEdSBi1AwJJg93Arxb0FB7JUVhJiMqz7MzTqr1YHLeNChK
 C52mu88jEPbWd/8USyXaF2L/0ICwZeXKAOGlGYAt8SG6F52BwMapKqVKY0wC/JL43pqL
 i9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364572; x=1788969372;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zOKkkiTvOdmoM+2yy6WrXS5hmm6h81JI5BLfIKCoGpM=;
 b=fWcfYfFBr1JduTcBW25x/A8cTkfqGxdoNxrRA3K/VVrcMSSpXYwLVMQ3lCZuQy/pce
 NHA9JNky5rBT3HiDMTGIjiBjhXHA2W0a7QIafbDxg46YuQl6wPpW+u4k+w7iiio7lxxg
 RafdnIu0U/FQBC0sT3zBRQ4llzlXl6urUSRlfMxSks9UD8FZtde7WkSBzN5p9GOlV9AI
 DErgfCT24m/8aZiV/Ct3PrS1YL6w1pPQYBeKM0BvIsO8thLMKO4iSzcYef3/EIGaiG94
 voXSd278mu/Nu2jmtPH5vJfFN1QthhcdPfxxqwCVtpPAtU5S2Va9Y+zBbTvKK4JS8ljx
 e4WA==
X-Gm-Message-State: AFuF++nWhmQt30bJBrFviT1/euXXH22Ergtkj4LqDm3oIIRpD/slBKsO
 NKKfX0ulLCmq0hk2KotN2Pfl/5g3RsV758UV5vlKzBt/9Ajt3eeilqN2WtWqikv/KhGtFxcwn3O
 y6wMQ
X-Gm-Gg: AR+sD10wXup6dnKTmQntZsWHWRx0MLFc917CKhKkhd3ZQgo0Rc48TK4rNDRGQncgvUW
 kZcvlZ1BUzxIWVAbY3At5gL9wyQ2VBTl7BAstGc+XrBJmR9WPfyc4clbK6vUMhjXQkmLrDW2Ixx
 SS1iIP8LIBhZRCJKHVRcJGZHuoYqKMVNC9zV5nxF8CJraZlviH/i/IJmxWMc4vwAjGkMqvjgQV6
 GsHEfqMORp4T/BAgTgy/orxv/Hun6E7xLMbg2Dlgjal5wK1E3+vca/ensV/4CRLziPFPtd5mrfm
 mQCOj+IVmcpH+mPqeFMizsBNfCEOC0dpyhJnh/ErqFjwus+IrKGzop+f8LMHRliMI8vVAZuTqkh
 N2sQS5IVyMv+GmDZxkQ7ukPU2vJDhrWt1+jmkcBZsFcCQB7oWJTaOnnkOILHrhxcAxTLi4dvhe0
 x9Beu3YU1aAIj4Y8f4P2beN/AO4MLU9vxfwkr0xXK5zyIrocao0xb9cWK66n0tDX2Aqw==
X-Received: by 2002:a05:6830:4c15:b0:7ee:41ca:e7b0 with SMTP id
 46e09a7af769-7f782cdb2d3mr4948095a34.14.1788364572173; 
 Wed, 02 Sep 2026 08:56:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:518a:9db8:615b:293f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f74d2a7763sm2648220a34.12.2026.09.02.08.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:56:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260814-mtk-genio-720-remove-ufs-defconfig-v1-1-000eb476030f@baylibre.com>
References: <20260814-mtk-genio-720-remove-ufs-defconfig-v1-1-000eb476030f@baylibre.com>
Subject: Re: [PATCH] configs: mediatek: remove UFS defconfigs
Message-Id: <178836456090.2649860.12656677272932650954.b4-ty@b4>
Date: Wed, 02 Sep 2026 10:56:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=310; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=UPvYB5tfGP85uBfJRY8V0KWkUeRv5qTjhTRbueQFqTQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmEcT330VSjAiGhybWlkSyndj3tG+igDT4gDLa
 HhbmrTTQ8iJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaphHExYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ak34H/jao/McTC2cTkhLQzKhY40MKI3kijUSGLoIrIJs
 ZDQU5e4OdbglgpN8hh+k5F1hW6Js/IOSkRlo4pF3dQoqom49xvzNdTu6QiOGig3X6hPBg3KKGPw
 WpUT8grUR3aq7qLJ36g2y5AbOZ34TL5/rFGtEt0f0u8Fin5X6Wcu/UsoqZC6AUPPS4u8dJuKmbW
 xrYvWR8YDLCLvNNSiA8NhenqLInxjJo/eKIQn+uJScZH0Jg7Mwotq3LqsbDqtzaPjzJ620B957J
 zVhwuXHZMAxxzl9WX4C6rAaJLMEazzJ3KzQ7CtAghdrW+vHTrSL55AJOm3xBQCt3iHaPrePNBYw
 tyl4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Fri, 14 Aug 2026 16:21:25 -0500, David Lechner wrote:
> configs: mediatek: remove UFS defconfigs

Applied to mediatek-for-next, thanks!

[1/1] configs: mediatek: remove UFS defconfigs
      commit: df4f9b66d9e354c4feec3de29c98778b7a84479b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

