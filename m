Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E965EC624D3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 17:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C46FA80DDE;
	Tue,  1 Sep 2026 17:09:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kWc1fPt9MUoZ; Tue,  1 Sep 2026 17:09:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788282586;
	bh=pjjgIwv4JDCpmWnG+Zstb/CqP097qj4rZjjTVs3qhaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kiLK46zRg1PYKNVTyuHHh1B7FkulrJo6VJ/fY+E05MLFEQtAzEeNGorvmW91rkSBS
	 AtTdpMisnBV7iXVAZdzExpemf/EPEJORNP6ZyEk4RSgay7BG43knwVrjVIqdrgDdo0
	 xBdOjswI0lgI1QnKfemqYHgABGBhPdkcbtl+t8kuEOK2GCs0vCw2Js/uX5Yjo46WgR
	 k54qD2F/QhJ/RJ0V6x9lCI15RJvO3pVZ8T00u5F5bmtR9kkmQCm/WdTBIA481Ppbw5
	 4InM4tSgKKP8CHo/w5DCmhB1wxzU92AbGN65efBIXXzK3DfzPtwL14dYhvvb5K5M3I
	 Gbs4yX0FveABg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B351F80E2C;
	Tue,  1 Sep 2026 17:09:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4C942FE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A69784073C
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yaQDnSO-M9w0 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 17:09:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UHvxdeCZ
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D33CC40718
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:43 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7f6617c7536so1604955a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788282582; x=1788887382;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pjjgIwv4JDCpmWnG+Zstb/CqP097qj4rZjjTVs3qhaw=;
 b=UHvxdeCZIqxtkEXPRWauT58rEKdlyeHiBBaIjMbpmhZcrXUO2Ychc9rpqVK6syfCde
 Ye1I1OfzMbUb/BbFfhqbR82ZzGsGt9DZGZig/qrMdL1yXwNKcFWjjTYDqvdLeIItWAZq
 u1noiXQZhHhNwUOZ81rLdNpfVi+C6h7Z94ICKFD8Zd3Z72kvSecgLjxajbcnGGxEdO4U
 sinH7phSCM1Hy3hFJ8Ry7I5rDkOFcyYYpZkmWKB0NLxJChHGXEI0DYn3h906D5uHxWB8
 4dnPJ8vCPl6zBdsQahIeDxdm3JeWe2x3JjDD4dfvGnc8ctl22Xr5ChgiDWQk6H2ywMuv
 VS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282582; x=1788887382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pjjgIwv4JDCpmWnG+Zstb/CqP097qj4rZjjTVs3qhaw=;
 b=No7JaahcuV53uHGS5TV4iLwGsSq0u1Mg0lYYPYKGHDniwEoHIuvubnX2pkYBo89eWY
 GNjMaxdUhJ8KAe916VA6yo+sRViNg30dbY0aZlmTEQ/6CSVqeCKS83h2X5IZ1uGNUx9e
 qsVeEqXd3gpj1G3HyXse3J53HImqMr7DtgwtnAJVBjWfayw3uAgPBIOI8DX+a0uHvEPU
 kWvALmK2lFgtdNUFSuyjEWw+tkb/L6MFY8UBpHR5c44PKxl0sndnk0GLkimooqRMa9Gi
 90j9SPPRCrvjFH0NwgtI1TNTm1K2GzZnYTooFriXV7CAF/r5ofsE5O+juGQgjAfLW+Hs
 dp5Q==
X-Gm-Message-State: AFuF++nVbC4JoU8iKtZ48hpIfZYHkX2mY4Gdapa75ro8ZLnXwIGzRS1K
 pZqNPIJFXD3HsDPw/g4Kj1huIkPovFJWuQzEh4RXprx45/6mrstuVOEC
X-Gm-Gg: AR+sD13/VH0fxUNWebId8k+kxd0+ymMS5yilZlhdLfNBTdbQhWSzGlkqDPmt8BOFtMQ
 LWJz3VyrH3IzNeLPj4usRQGGoZXvG/bZid5msKcbY/IfXWYouHWOwzqk1hVBc8aHTlrQoUbggZK
 N8GRNxhWbZFypetPjoyCMmEN2oqBnGisbLYAIyuiP18uofLKpptonYe6PSHKG4h9S8hIP7c57/X
 55xjgszmaXoSWDqs/lw2lXO+MmORQU/Vd2LAj/LdXevYFs3CGJVzg0TkvfLf5uJADbSdzC/qUp0
 +4bq7PwW2pWBcWAtw8Ubeisbd1FPF58Cx+KPUbX+krCd8Lc+pAveJtI98K7SefR3CnQSdo5slNB
 V8ii0X1xkyuWyFQQu3QN8Go6mLfA//8tgd1x0OUh1l1i44Vo9G4HC6blgbIu13otih4W7yBoZCT
 wPdj+XdcuZW+GSJx/B3IFb1bBSs/oyQVHl6mRwNI5Af6DH9bOygo/zEXxXwqcF6z+5fog6uWajj
 KGig2GsT5CVj94TZNORKyShDXrubkxXkP55hTb9n11nO3SLkf3NoV1GpWIoVM49fFuuiGbYiUAU
 mLlfz/LnswTbJywS9wStRfvulpI8y+4PBGeL/psn6zEKXTiQiSOEtNz6AUESE2GKVeJvt1lruP+
 5CjySKCk7KJprYnnLQPc=
X-Received: by 2002:a05:6830:828c:b0:7f4:d68b:dff6 with SMTP id
 46e09a7af769-7f4f22fb1efmr38713831a34.7.1788282582227; 
 Tue, 01 Sep 2026 10:09:42 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99d927sm10892218a34.19.2026.09.01.10.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:09:41 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 01 Sep 2026 11:08:57 -0600
Subject: [PATCH v2 03/10] net: netconsole: use unsigned port numbers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-submit-lwip-runtime-netconsole-v1-v2-3-3e3d95627cf9@gmail.com>
References: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
In-Reply-To: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>
X-Mailer: b4 0.15.2
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

UDP ports use the full unsigned 16-bit range. Storing netconsole ports in
signed shorts makes values above 32767 negative and prevents them from
matching the unsigned destination port on receive.

Store both ports as u16.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/netconsole.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.h b/drivers/net/netconsole.h
index b2c3ecee6dd..11c2d1e0f48 100644
--- a/drivers/net/netconsole.h
+++ b/drivers/net/netconsole.h
@@ -8,8 +8,8 @@
 
 struct nc_settings {
 	struct in_addr ip;
-	short out_port;
-	short in_port;
+	u16 out_port;
+	u16 in_port;
 };
 
 extern struct nc_settings nc_settings;

-- 
2.53.0

