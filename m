Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D89CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 22:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE4DC80BDB;
	Mon, 12 Oct 2026 22:28:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vuk49JnSZH2q; Mon, 12 Oct 2026 22:28:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B6AED80B88
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791844084;
	b=l35kXCGJCLIRwDF5HYsMnxpXffAi6TwrOyeAmiByfYLb9IfnQ8UWFLCQ87c6YmOofyXE
	 puIyX7BYv9rUcPg6S7VdW5p8rLctxyzls7ctcG25jJqesOyE2hStXeAqLg6I3kkxy0zQ9
	 3Td53SN06DSw6z6apcApqd+GswFaYoU6QQmfv1j82+s6XlKmqdlgXlJLkwrc/c92Fktte
	 ObQn0yHIA5VYpCmWrKvnwPdwi+flaC6lyZYBtrCDytiFJhpTiyb1fcmvL2acZG6EvXvOw
	 Mw9UcK9j9FW/Af54OMOqzfASAdLYpG3Yh+3Cq5d1NPF+Plo6OHNzmbRN2gaDCVBjDFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791844084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ju9tmyy6kS3Vulc1m9XW6la6MgNIXWnHnL4ssFov8Dg=;
	b=mqYYmwi2S/hdAciIMo1TPjLRV++1lqruaTwgmGqwDFYC26MTXe3hH/AEI9DtQki68/9L
	 ngZUOP8W1xGPhf5x6yOxUl/2214I7xf41/8tw8+C5QJXp678iFrKv8Cjzr96/NegONfmL
	 /DJOO3kYs7fab9cfC/pDsrs+Vk7tFk9CYfN4azXDQfAH3QBGvLyyIU+yv4E6y3hA2zrZP
	 LHIdT2av0bK9TIz3nEvegacQMemsKZPjcglrIt9nT84OHaf2cqCxaPJERlhy4EBeOEkgG
	 JuOk7ICs64dfTyYTGvRoebzEFRzUGeKvZqJyyw9yuDFHWRUX0ajYHeirDCeilETHGaQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791844084;
	bh=ju9tmyy6kS3Vulc1m9XW6la6MgNIXWnHnL4ssFov8Dg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Enoy79P5V+IBrkmCuGI353TUTPSyuiYaCorF/1cm0VdC+FbrxX3eT3yAjCqKzke0E
	 B0lETBinTJtJdjJCNSPW64CUFrzscFMHsKOW/xuHa/xv6t5C1iO8UeUfUijas8RcZz
	 m++eVUc2QFggbpKFvhrvgtFIgKoF2XT0ANy/jkqq4s9sa3rF3CZ9rcpsctj7bPkbcH
	 0zaL8g8IgK6dwtlCwlJUHGSx05CivPIImb83m03ef5yZmCRCHjefQHn4H7BPGdWj1a
	 wOSbdFLtj6niTo2hsQbeaJdqc476ITTH2RkPbVn/tcYkcINc2IRKfsp1u1NmkxS8mM
	 yovFan02bgmKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6AED80B88;
	Mon, 12 Oct 2026 22:28:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 10793105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 027BD404D0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2_swn-ENhSwh for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 22:28:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 062C64043C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791844082;
 b=NxG00QdOlGSEWLVJscY/eVfQ7v4wB/12tJ8LerYk0CUbBU1cTRP8OtroOJ2HgFAl19/7
 1KJapZ3zJHfNvgU2Y53iBXqWDIPTSN4slbESV+mkBajyNFKsgIG6kzHILv9p1lJDgzCxM
 GVXZoyAOVSxEgBd45Jc4IsuaXspdPoKLmu85+0UBIYGImWXQtLMkQOHp4ZHoVc7VCJ9Cj
 722Ib3NfuuywniCWjYUAxbG3dTUD4u2BxG/pA7SIJZym9KfVXEMWjHy1uZ4KHN6GDwCo9
 KF4ajKgbMTxqLCwF5Jk5B2M2Hn6hOUm4jxU1V/MJx4/9v2F4cagoKt98l5AI2g8+l1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791844082;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=ju9tmyy6kS3Vulc1m9XW6la6MgNIXWnHnL4ssFov8Dg=;
 b=HKK8f+rx7hnl6fd83NYvqvNYXGSfsNU52RcFUWL+JB0erQ9ft+SjZSznB9xVqtI82PL8
 XfQuecAw5OOCIBeOLEtBtPRi46lKCJcTqx5wXnR5zaOFNL/yyTf9Z6nLYpyssZ5otmDoG
 LxHRe1pVwwBbivhSjycxEPSIhaqRIZweiZ3PLmDolEaIvJAmFWLU7xj3BxqP9yAZt/43L
 /JLh3P045iItD01LWFBCZ0O+N/n8Mk+u2qbdH27KeBY+0iAQyNm3ePxCwscnujZEt1yaQ
 rOTFbM/dGIiTkPREx3KhGQGOVzPpgHLN4y7hZlDeb3mJOQ3mZG4CS/G4dUvXt1XGmww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fZS4Bpe+; 
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fZS4Bpe+
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 062C64043C
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:28:01 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-48e2d5a69c4so1191495fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844080; x=1792448880;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ju9tmyy6kS3Vulc1m9XW6la6MgNIXWnHnL4ssFov8Dg=;
 b=fZS4Bpe+TAOVEmB9H/hAzaHFhwaWAvznt4xyCuvu18hvbfsqd+AQPdM9jVnVPMUT75
 8sBTOIpSU4SQldc8+A0zc4HmmiPhg0eXfPCiRLCNDsoOmZrgp2EuNuFHlKZaVkbE5mcT
 0/QGCd8/0z8b8flgVhBDF+VXlc4eimrVmaXC1p10UhMNpd258dHqgEFZ3MRVMMTDZVey
 pCb2V3mPLy9+MH3DvbpNwoLXJ4Oy32i3d7l0FDQBlhSkSP1jKw9yuhNBgr9Ydb5WqesU
 ZhVnN2KF7unLQFsJRixqODomGcmu8yCTv5Ag/pW3whIGPpbmJNxsZjmlKoXKWGx7wvMc
 TORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844080; x=1792448880;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ju9tmyy6kS3Vulc1m9XW6la6MgNIXWnHnL4ssFov8Dg=;
 b=p5wXBL0kb9hx/SxgkkMirVUmri5fA1TFySlbieRgAzK66orADFZKL9FbTR9zp00yyM
 VZTNIdGwW7aMQuAGIuFskFQrw9cnY/DVSv8xJ/J9YaVDhpI0uhZTdrHozLEzanhKX4cK
 iyNUSAIy74UT2/1Q+sPShjyph8p2D/coLkjo/zcAh5cpiKj4RoC2JJywUEB0SwGSzTM0
 dKfsCZbdC1688uduy9haysvmiAeh05NyrHQzDm8oYu9sRMP20JGwRq0raO/jw1LmuGRU
 uBUne+yXMbTjYE4Oth371QOFrveXde0eOeLyXAe0jQXSM3aghNR2itWf0e2fk77XMXIz
 3PFg==
X-Gm-Message-State: AFq9FYK8qWgFR7FJ3J1xO8jAnOV921PEfSXzdpeYQ3kt2JZz9GslujmW
 vXJycv7OZpNLBznOvdwdcjZuitZF7plw11SsR1chL0rWj4rtB9BsXxPk
X-Gm-Gg: AYBFou3vthg97RbuUc01BhHFodesl4Kg70muhp+ILjK+Hm1Rhi6gEunraaJWXvvfIYP
 AGyjS31ZyKknd/ZUaR9pVq7G0Z36sxctjqCNhuc1o6B/kKgAE5sxZ8VZk+xbQtxAAK+DhaZfbZf
 xyXCDMm3iBmRflQWU5lZA7fZjVxM3U3BqROIEUL4ZTD38oZ4cOMO3MDXNi3FZj3MQrR0aK+5WUO
 vZ70gK7XQMcgOwUskc3aRFgagUfEggG4PnJCJQnwIlxcMzvVve7XKV1Puh1oGvyttngYtZmo83U
 en9UoWGcFJjnXs8bVuE3t7gXmTjOcXwFNCL+08Q/OUXBnjr2jsrHpffHaPCb6u2beDAFvDjjzaX
 9xcwXEts/hd0FvrK29u4W95l3gG84+TJRQcI9xpgr5z9ETKRSY3i03GmkWYqW3CKXAln+SZa1YO
 5nPQPzGGlbtPV+cRCiXCveG1XDP/WhJvrS3illkEPfMhk3F1p9nS04FxzOSEfRdYoVAapKSbqsi
 pQXIf12xXHaqOyIHPOB5lp0FzcWLeZIyHGAh9BkpuDddKKWLoCg4Aq4rHRSdNYA72agPkT/31XT
 3jo7KXiD/PEz0mTUQG9OqXnCkBY03i7FSockq9UsQL6F8lqQ0YyKnG3qRE7ETzxFIm43Zw5AcSO
 k6z7W4UQ+4yU1EBDp99n2ZA==
X-Received: by 2002:a05:6870:56a4:b0:49e:f:1e42 with SMTP id
 586e51a60fabf-4a2a8b58c1bmr9200438fac.60.1791844080467; 
 Mon, 12 Oct 2026 15:28:00 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a8582a95sm10402859fac.11.2026.10.12.15.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:27:59 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 16:27:56 -0600
Subject: [PATCH v2 1/8] net: ti: cpsw: return -EAGAIN when no RX packet is
 ready
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-submit-cpsw-rx-eagain-v1-v2-1-c6a20425c15d@gmail.com>
References: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
In-Reply-To: <20261012-submit-cpsw-rx-eagain-v1-v2-0-c6a20425c15d@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, 
 James Hilliard <james.hilliard1@gmail.com>
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

DHCP exits without acquiring an address on BeagleBone Black with lwIP
enabled after DHCP started checking the return value of net_lwip_poll().

cpdma_process() returns -EBUSY while the receive descriptor is still owned
by DMA. _cpsw_recv() passes that value through, but net_lwip_rx() only
converts -EAGAIN to a non-fatal empty receive. DHCP therefore aborts on a
normal poll with no packet ready.

Translate -EBUSY to -EAGAIN in _cpsw_recv(), following the Ethernet receive
interface's no-packet convention. Leave other errors and the shared CPDMA
helper's transmit behavior unchanged.

Fixes: 53a0ca3757fe ("net: lwip: finish DHCP before starting autoload")
Reported-by: Tom Rini <trini@konsulko.com>
Closes: https://lore.kernel.org/r/20261012200814.GA3799261@bill-the-cat
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Tested-by: Tom Rini <trini@konsulko.com>
---
 drivers/net/ti/cpsw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c
index 6b1f7764e0d..4d7869f405c 100644
--- a/drivers/net/ti/cpsw.c
+++ b/drivers/net/ti/cpsw.c
@@ -808,6 +808,8 @@ static int _cpsw_recv(struct cpsw_priv *priv, uchar **pkt)
 	int ret;
 
 	ret = cpdma_process(priv, &priv->rx_chan, &buffer, &len);
+	if (ret == -EBUSY)
+		return -EAGAIN;
 	if (ret < 0)
 		return ret;
 

-- 
2.53.0

