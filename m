Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91D606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sDWZ2k/T;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fbXiKPWo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68E44608AE;
	Wed, 25 Nov 2026 10:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CPi5T3RiByoI; Wed, 25 Nov 2026 10:58:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96F45608CE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604337;
	b=Bz9q2p5ZvbDZ6OERvuvoqNpD6lMACRhuDHsE4Nc7ZgMG0Fi4BABdLbE9PlEZQo82Sm5a
	 FRM8WEBZscqqekqIF/RvoWvj/mWskK9UXYjksonet8Gp58hi+vT7sJVG8OZDiL46+h34R
	 J5rH9YDd0mlMCYpFtu8Bnq/enYocQqnw2O8ODwqm213tB2A0zNs6WlZou2lOsyBL3Pbzl
	 XrvLJCyra2Q3g2onWqbOpyEj63zuT1/YeVocphiZN5wrZNV3QdLLSzM4GTL59kebnuBsa
	 lj8gcKdS98VWORDhDQWi6o4A0eIan7KuYB09TsjROMeMkVxiDTeXFVpv4uTwrKbldMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604337;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8E2IGaz8+1UIFKJNqBzNcCDeg9am7OKFv0OcGUIFv64=;
	b=cM/EfQ4NgrqJIdqOWwcFpIi7iZC22VxMKl4cs8HozN3O4Jmk96Dvw28qSbFeD0+4FAvh
	 Q9fVWOuE5r5t+xqgW98/Ye5TY1yxqebSYPeGryfrRjEiN3iQFAA0VAp5WuxOMOEqwKMpH
	 LpaWZp5XYyaC2/6qnS7pJe+sRMg5MliHmJwoTYUOo79iu65btvV5/EpnEc6X4oiKVUqfv
	 cta1oCqJ1RW/CppfBaaIlc8CcIsrYGNkaRtiUqQgHaPmzncHItmyh4P1UWGjF5Nfs2OVd
	 Mdgi8g2TWrhVb+XQ9ZjtkUpx13M027JDQLkmWQ9kMxh/YstJ9MKAw75ini+AfvOb4tQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604337;
	bh=8E2IGaz8+1UIFKJNqBzNcCDeg9am7OKFv0OcGUIFv64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sDWZ2k/To+YqBI7f/0K/u7o6/zl1odc2Ex8OJUfok2TQQQAdogwJ1AsXxr2yHVQPV
	 DVkON/ckYz6YsuVJ14DG2ASRE6JcwPLXZNzHcc1a26VrU9bDUX8m9E5QkPf2uZFtyj
	 ASu+M3utwdha6RN9GBfD1DeAleVQ3kJ0AUAsDeZlL8THfIkr5rMhfUPozK+0b3KnlW
	 NmqGhFG/xovWL6jYRXYnh30sfFfAWsPX8CVSUotC3D3F1PTvh6tP056uExhLQBtIAY
	 3BdEgC9ktzNV12m5L1kAR1ZUL0YLuUsHoa/PvFVoRDEsMyF2EZEpKD0qb6qHSi0vr2
	 H0FU73ZNDrhkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96F45608CE;
	Wed, 25 Nov 2026 10:58:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AFC542F5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A1833808C1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bGCDIHb8UmbV for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D3F7B807F5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fbXiKPWo
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D3F7B807F5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:40 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so36430435e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604319; x=1796209119;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8E2IGaz8+1UIFKJNqBzNcCDeg9am7OKFv0OcGUIFv64=;
 b=fbXiKPWoyWCOZQccCad/WPP6vJAeDqgFmXl8rlm/SmlNTQw1APOdKO2fx9cp+MeQVe
 g4QbBZdNXK5hN06GsZ0j54IM+fZJAzduz5C04QDocBMOfQ/2oUrvVVaLeIAcxzR5BMub
 leasvzXSru0jKb1vV9GqhxoF5pAmHSNsgaqkjp3GsxqqK4OGAvzib1o6ZyKK2AAyblNH
 yYQm7tltA3Pg6gIFIFmEqyxSSqeYUFjuyUdtHEtrNCBxsmVUrdoTMOipgUlFrQNDVU6V
 wDIyXQ+jxc/VinQazFPumT/tvsuwGDu2yDBTBnFmwQzYVBVKwnFCPvcVfNeCtt+Ib/L6
 xMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604319; x=1796209119;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8E2IGaz8+1UIFKJNqBzNcCDeg9am7OKFv0OcGUIFv64=;
 b=PNEL0aDKIr5r58PyZ0/G/MT90IsOU2LTwdOHG1fYvmLex+FshmRhJ+x1aS02K9BiVo
 zxGwFGiKw96oUJduDzVEY7MzCqOHs3ewZVD4uRyezautM7wyeKSXVHs4u0Eg0mki2YsK
 RY/T0poYZchRYMgswdDXJVNWtQE8lsWcBk+BY/+3dbsjeOfe1Shjfu7CtLDfj9RHJyim
 B3HHeiVWPJVFYX6qBnODB3PCnrVV6qQrru/nbTuJslj7sRCLOLKa4Epv+2G70gjJuZUp
 bn3cKh2Xj0mMrzdJVyzavXo4rCRX+aa5ZmHvFyO2GzitAUjExy2F98SuSBXsQdkgM8sP
 WbSA==
X-Gm-Message-State: APuU4Z+N4AHZrqD3aLLXpgKKC6eTPbSRasCQJ/QuFp16fCuZ1T7aVCzu
 ZEmxLIAuGEaGKxFZhA+UIHIk+XODFC4OgZDkzxWwG/wNjyX7sfuYuiQ/QnIpUGgBLu2yGKlJ3Nr
 DWDQgYRJe2w==
X-Gm-Gg: AZFdTZcRxgrVclH/Tuz6gPs4Lj92bYFQiDpQ2T+HM9yeU01acy7R9BD36KMNbkCZVPx
 Rw4m+iI0PSDyfcjSR9FKEcBVNfyT59N1KIEPne7+5fu56WCVpamIecBV44YK8jI+GiXsXsKLueh
 W2cVD4rWInwWPitgLkl3vf8kUEzQgmGn+WwRQUVXxR2h/19neADaWVYoyHwVUXoiHrgSVgDiPEJ
 i80cAi+/lYi2v8eZ6CU/DqSuiYaSpIltF3kaBm624NfUN3EKKxeMCS8bBMotVfnLIyE6GLEnUIC
 xywiY3guo9eLDC2CZeflII/uZYGZfsDaBjVQuZS3thDcmZDz9AU4ySrF9g9JldnuQOv5S2bdEyD
 aRZROvdZENjCd2aTb7yGc5z5IZOYy65kt3jk2Vm713BMA3I5+PqeXKObKERPfEARPBYjceIxSVF
 Dfn/s2Lx0fOTz6kdFfPf0cuupk8C0EMQnCzUvCAjptk+mMjjkBSj8te69lrsUNuYoUrMzp6Rg4H
 1xG5WV1foXclNHCQqGLupE4KSJXGJByEvr9a5zmQyIkO6JbbExK2jrtDB8JF8gefq500PofGMpS
 Mn9AbnPMYsxdFTmLVCxAvuBx14dIxu1iJH7hOXJlNyyNblQwAxQ=
X-Received: by 2002:a05:600c:3b88:b0:4a1:e672:5721 with SMTP id
 5b1f17b1804b1-4bb8880789dmr402135765e9.13.1795604319212; 
 Wed, 25 Nov 2026 02:58:39 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm31584092f8f.26.2026.11.25.02.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:38 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Wed, 25 Nov 2026 11:58:18 +0100
Subject: [PATCH v2 09/11] arm: renesas: Enable env erase command on all
 R-Car systems
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-clegoffic-env-flash-erase-v2-9-8d31a33a54d2@baylibre.com>
References: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
In-Reply-To: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Fiona Klute <fiona.klute@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
X-Mailer: b4 0.17-dev
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

Enable the "env erase" command on all R-Car systems. It erases the saved
environment, so the next boot starts with the default environment.

Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
 configs/renesas_rcar.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/renesas_rcar.config b/configs/renesas_rcar.config
index fb9c23046567..eacf0dfa612f 100644
--- a/configs/renesas_rcar.config
+++ b/configs/renesas_rcar.config
@@ -2,6 +2,7 @@ CONFIG_CLK=y
 CONFIG_CLK_RENESAS=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_DHCP=y
+CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y

-- 
2.56.1

