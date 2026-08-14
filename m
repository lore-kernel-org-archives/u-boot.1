Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EFCC5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A754B40D32;
	Fri, 14 Aug 2026 18:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8oizH-92kcFl; Fri, 14 Aug 2026 18:30:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9BEC40CF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732224;
	bh=JMJuC/VlGCp4KPJX3NmfQmEYWwewgE8Bt3N5NIsEbaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NS7xbl+HKc5IPBL+W7SUGxLQGLW4xeYy6CbasN5cxaw5VqqfRjVdCqj2OXRr3zBzH
	 GffsLcw+y2rXakA933BDagJtSszbNKE+Rl6ijDLJbvaMgfVWMBkHOXSmRWDYrlXVQQ
	 kiRq2g/edtL5rX6daT9HWWTD29RTduO63gO5H2kI+5nmWM6zNwjF4TuU4o7RpwItsi
	 MYwf9mE4D6LF6hZscLDSMCz+Z09mvdwclJ9GsFhQrBLPaMlmxTGQRL37QEGiBJD9WA
	 PpZPTn1xZr7GgG0cSurlRnBFwtd2+b4jvFMpWoHsa7Rh0wuMX61yvAnbNqlb1rzRWM
	 7rJ+5kQ29WvxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9BEC40CF8;
	Fri, 14 Aug 2026 18:30:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D01853DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C23B6608FE
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fe6glrVa8qvT for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:30:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A6DDB606D3
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6DDB606D3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=oKUKrNHc
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A6DDB606D3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:30:20 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-92edb12cdf2so112372885a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732219; x=1787337019;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JMJuC/VlGCp4KPJX3NmfQmEYWwewgE8Bt3N5NIsEbaA=;
 b=oKUKrNHc/lBvKFEe6CY1OPnYwxzdct+kmiqeITYouuZC/nHyJtnsQnW+uQ1Bl6ceyK
 8PFmVfgaPwEoRHSc4l6hCQwUWDiCcuvmG8hdW5yi7DzBKU3hy+GWLOrWB8uLFW484zi2
 SIqa0JIyS7dH5AyhytQQLrb1GdsiXTvbpYKzYtZPmyVhMDJykitT0axNtXCyIAUN/XFY
 CmxjDZU9hjKTfi/95kOP1g6PeuaceH4nloTzp1dwD4XfeChJBvOlpFnMybtn53XOMU8j
 nfUHdlhDdP8MDMOf/sVMSsrcxkWuFOlzUVYESNk4cJ+erSPUUfUdybjS2wl/hWwvkLdv
 Jigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732219; x=1787337019;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JMJuC/VlGCp4KPJX3NmfQmEYWwewgE8Bt3N5NIsEbaA=;
 b=h4XfQEkwqNRziACy5Cq3fP/hbZWLByV4NaPloURTEjmHWEZIauHSf19V2K/U+YSQPL
 d4IEReCaIKzJlza443FZlZKU5hq0tB2yMbS4pan6E1RiXU43sJBRs9cPu1Hv5t9d470H
 z+ad+XYTKerkuew8XkwjrHDNOelzXMnAuErw/4eJS2KmXXNM2GjRYG+v6JLXtdQQCw0u
 sXqlDGANVQjYEoN+buPmlUEST9WtstMn55Of+hNBlS+nG/UMMi4GPQFrmSp76LdAc0We
 zqe34Ez+PkFo1M0JB0MO5wE/LljOxoEDy6mtWbo8sxNoGmdgQEOD70aBCVGAgisPJ61q
 H4nw==
X-Gm-Message-State: AOJu0YwY6XjpCO3Pwyk2Ul7CSlLATbW6sC7sZt692xBWvR/zJb+21tNw
 gQHC2lqyfiYmdJrvr1Plxj5kMLut4ryK/xPDTGHLs/E2mGSjX3vTxBx7Y3ewkma9QYY=
X-Gm-Gg: AR+sD11KERsjBld4ur0d4X6/Th4bjOVwX3wPuQU4BSiFS6x3OwuIYQD1EfexkBqG6jF
 1ldc2oCcs7CfTxIQMSAlaWm4uPKQ9yoBWu9lyEahKxfS1RruysVbs96t7dQ9WyWNem8l8aA9zMf
 m2QIDLl+gQ1o72Erm2E1+4yGY8F4igMQKYuqxk5UuklBIOw4eQvYY46UkSXZ5foy1IO68yR6z2W
 7kve6fDfxFKywK6jBbekcSyaQqSN6V1vuRzk7haWLG69bmgOKzEgcIFInkysInYDdEh/6yChcCc
 dwm1hXiWreYeYMKH12Rq9SQM6+YJLbN0QjLzwFw5Wy32k9Cy9TM1EwJe8mBuVcxKhav8TWt7IlN
 usDjEt/AVshraYysdsga8WSXbNX6+ewpSFQ/37xx/zbxl0xSkT0oI0lhHpCEx9yHE6no3A5aOVT
 U8RYLRBUSGhWq3m9ajk3VDsyVbQMle/F8qAaOO/pRNRcQDge6mPvXQoPKobc6gqQ642RZAIM7F2
 xjBrqekP4BH2v4uiG9qXuc1t8j1aMawjKBwlkP1d6mTb19fhR+rJjurMVv09G/iuX4=
X-Received: by 2002:a05:620a:29c1:b0:92e:e559:fe6b with SMTP id
 af79cd13be357-936d1fd8b90mr845544785a.7.1786732219082; 
 Fri, 14 Aug 2026 11:30:19 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce24d0b5sm324606285a.45.2026.08.14.11.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:30:18 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:30:14 -0400
Subject: [PATCH v2 3/3] net: designware: add r9a06g032 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-net-v2-3-ff03583dc2b0@linaro.org>
References: <20260814-rzn1-2026-10-net-v2-0-ff03583dc2b0@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-net-v2-0-ff03583dc2b0@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732214; l=949;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=Vgcsu1+pIApcCh/KcLl/+6FkxJcRgm6ojt/tRbntkPk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAlg3vMT9z7nNwZw4gYikBPLz6w9RaGsNcjw+jNCdaRB+mlJfVDMGFjpJ1vXYqKbL0dqDNeSGlQ
 SRfLWMCCx+QA=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The existing Designware driver can be used on Renesas RZ/N1.
Add the corresponding compatible string to the driver.

See corresponding Linux commit
d7cc14bc9802 ("dt-bindings: net: snps,dwmac: add "renesas,rzn1"
compatible")

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/net/designware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 6ed9c6d538a..650d47036aa 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -1059,6 +1059,7 @@ int designware_eth_of_to_plat(struct udevice *dev)
 static const struct udevice_id designware_eth_ids[] = {
 	{ .compatible = "allwinner,sun7i-a20-gmac" },
 	{ .compatible = "amlogic,meson6-dwmac" },
+	{ .compatible = "renesas,r9a06g032-gmac" },
 	{ .compatible = "st,stm32-dwmac" },
 	{ .compatible = "snps,arc-dwmac-3.70a" },
 	{ .compatible = "sophgo,cv1800b-dwmac" },

-- 
2.55.0

