Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5887606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p3OngIsU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wo8RclNW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7FB44050C;
	Mon, 26 Oct 2026 23:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dyJG1gGTl96B; Mon, 26 Oct 2026 23:46:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 067154050E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793058407;
	b=sN3FyeTgEukKFkitgMr9Nu1yU12u4TF47PpMHxUjtJV9gRdr1+BBhZ470KyGQEjQB24d
	 OTzag276g0AxmbKwik7MUizRqcV5KuIwB3H2Scx5PWmDhmW5rgWOBITq/ORe/w8gpqVAp
	 NyYVInWrYs0h4Rb3NQHV9bxN65TTEn9JQvjAv4Lc/RV0HoCLlsZ6ky7dYSgUZNjxyVyYc
	 B4FH0m2RAB/f+z2Z9msM9mChvWpwDSyQ49VcdxhQ20DWEd84xCHGb2nJZ4vVF0duFJZrq
	 u1zuUUGJ7FGmxJBN3F7KyeCpzuK6KntqU9nH8se6esLz/87eDmuiw7gU4dkVANT9Bkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793058407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+h8v5saCzp/qPU8/3zei3XFLlH3u2/7xMIXOMcjNQ18=;
	b=DDNbQobj1BA+e56cRSn3WXuFpB35cKNIgMvsfnZIbUfTNgEGlqfYMz4mTYkupo8kv9DX
	 RTxqvnEgGE/gD2Y93/tVf4h+E4C3Hh4EetMttxtc2VCcUW0nrxpU2fGMUJy+HXEn2CnKM
	 6DUuIQfHby4aCW8PTREvAbA5IXlPHQf/po5WVlaZD2Eye/DpsnEdJ+Ofsyu1GFQ1KtpAR
	 VfZ9o7sujKlpjcnCtp7gMrUOxFDYVXe1bUoQE2LtiCFXg7mkne/qA/hmASxa/3xllRXQs
	 8J20QacSeefO44HTodUhw/tgxRamlrqfUiQvtA/3w8+tPwtd/JbtV5T6nYfWzClC0bw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wo8RclNW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793058407;
	bh=+h8v5saCzp/qPU8/3zei3XFLlH3u2/7xMIXOMcjNQ18=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3OngIsUTuq0C7xqsnb/Q6ADw2AlJuCQUF/9o3ASWcYxvLwTwuiwsPegntRwRQ8Y7
	 6O4vMxikiQH0KppxtjMxF2JjYjRT8yTm7ZxdT4gaY2fINjquZXJfehhPq7mi9Cya2E
	 JMZyARAmH6PzSls/RkIvZlzeoKEyAeIOf8dreT19OLQqnxc6QuDzpTx9h+WPVKBly3
	 exzEO3sVfwfw5ON2fWSp2DisCXeNvJhWtjg+VVBYoqWDTY1yVznhd9oT2U5crAYSoF
	 sIh/bbDsY3su4HFOjX7XCD7ZqYlqcybSMRLIfIHUpY+txHvwcbaee1z4LMGSjIEqp6
	 Wf3j6SRY7yGLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 067154050E;
	Mon, 26 Oct 2026 23:46:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 75553356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B1DA4050E
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oyrpTzygwUa5 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 23:46:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9ED8E4050C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793058401;
 b=OHNFCCW5pKPT89XXtmHNEK2u2E0d5lbaD14ZbIMo8W5BuLEgmW+T1ECRl6MQ4Ex2l2R+
 cl//PJmOFlBjV4MtgxGw3tUbSAaXnx33dE7T9W5i1AbXOslE8wTP8gohujSwHvaj22W7W
 qoQ5oWQzbynyleeFLMJX5tLKR9yAGCpgu7Av/TuJF/8qmDgbDbiQkPAFwEygJPlavd+cr
 OflmM53t4KHK9CPQT09yw3mI+GT5WJU8ELu5eyHbtxagQwyRY/DblufBWtfzFuZsnfCvU
 6hvRT8asRf3ca+hQoud5f6x6AgXFVFum9UINDrb6sGWBpAcakZpnKL6ee0UWchtzh5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793058401;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=+h8v5saCzp/qPU8/3zei3XFLlH3u2/7xMIXOMcjNQ18=;
 b=gDzlkIz1wcPN8WcjQoNOePb2LkmUnRb5I/yHtGlcVCWw0Fc3YPf6aJBceQlN30P+/5Zy
 bo+MaA+JME5uZj/ysUaKwCM1COJfn4CzUS/qmUUjYOAfsSYX3ZH873yNnT37Mls+BAo71
 MqDzOW9izVmE9HWaa+qa/xGfYHY0boAwMr+TrcXj9BFj8QV7IOod6Oe2ngMQunqZJIotl
 ZtsiCNpPl9pgYIWB4IpqpWBZrAR9UhpgwWv/nrhODexQcPVQ2iLWgiUEdum+ucU5Ll/Qf
 CyxQntGgTE963VcN5OXwSytF7D+vmznx9nqY0zzP3bBYsuAs1yU/3hCSLlqD+FGsTQg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Wo8RclNW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Wo8RclNW
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9ED8E4050C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:46:41 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so3054616a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058400; x=1793663200;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+h8v5saCzp/qPU8/3zei3XFLlH3u2/7xMIXOMcjNQ18=;
 b=Wo8RclNWoeft2vT2c2c7ondxsxKsRSe9afoZu0QUhhrF+CgrH9UczvxpSPb/OttaP2
 1F64kqUxXuGTeiSSX0XafWNrgH6QHEtfNG1R6TrNfW+7TDEd1QyxQQMVmZ6w+Wk6BhUm
 Uh/+hJDBpN9h0mapnev/N0522KIXEkfJArqEMUPXWvzUUNr/oIcChlMuyb8P+m7wweeE
 L+qJWEwiingYD0K8u8CEi8EV6VJ10wERz3F1Q4S/JK3RV84WzUCFGLJEJCt4N7bhI7op
 XHPnoCSPyAoQnV9e4Ey1WfGuzAQI7/WyWW8+T4Vn1O6ZDRQvXnf1QhC63T1nTMuLHD9t
 OaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058400; x=1793663200;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+h8v5saCzp/qPU8/3zei3XFLlH3u2/7xMIXOMcjNQ18=;
 b=szHR/h+PRk4CwGFMNozy5etEOe6CiMS9oSRPC3dwTQis6KVws7K1cyg9rgJ55x/5hP
 /SBS2kBczF8WmAojRmqTXknwcjkwj5M7sy4b1ejHlweUgRFhokhN9Z2OnalYFlJik/mc
 NLhQEmjOQp8OmTeKCwJK564Uw9dyVCh3RHJjXo797KU32uGNZjlPKP/Q0Ow6bI8m7P0v
 xwoefEqDpAMdswrlcIxWpRY5eq8ptId/U+yfUBH7HhqZpTBMt7uTRfkVAxj5VUqkLFGd
 tjSvSCBe+oBD25/yPbqZ3V0yH5zrShvGpjvqRRc65y1gXC/DY866ITk01Nh7GYv2n3HJ
 m9lA==
X-Gm-Message-State: AFq9FYKRa9M3ZEqv3jG3s+UDDqhgh+eGbWvzLZD16/cCHIpWHJ3C0T5K
 epc0ENsnoduQCCHNDCyURYV4PQxuHLrAv1EkUQQL8rjDdAd320zN1/c6
X-Gm-Gg: AYBFou30rRlekRLT3WWDeJ3Qr0pJIcvfey12DGx7V73onc7jS2oenmlniW4lKdoXmBb
 4ZSMF8+NRUrRrb8Ykz5r/EkXtolHehNFRxLNbBcFJNvZHZE1jWwNUgCwIyqETKkx6W+TUAZqcMn
 CDk6t4ImXa+8M0NToYKuNo/EZ/wt+sdpssrsMonYL2LhWmttbM4V9cKNKtEfHgZP37F/A1w/56K
 Egn6Gx/FFEhXxkc7me+wMzNGJPMxkFM0o1ZrfKopovD+bo5/KrEq61Ef2DGSMAWch9hqnWCecSy
 dy4d22A+gRCdGLwRri7MGOO4qk6cyqDRjpo5zK7kdtS0T3B1OVRTO39u6qg800Sm7UL156Sa5G5
 ZCpdEneT6MomR1T2iLnuct8TrSDjRQzbyV2Ej1wYftc3Cl3tG2yOI/t8a9zIJoIirvzP+bO6jKk
 esf8YusiIvMsDLilf/JGRc48+vtVopqpSKYJ9Bv90XTeuCiy/Wuwk6ihznB7ilkef1azh6sPD81
 MDkcQkwP2d+lsNdMJsmaCT0oSOsIL/DHCTfIqIMhesdrzNa8qSUIZiqS4sttl/KTfn/+PcHqq0D
 tcMMwXJt93f1pjfXWgmXo4BPwVdRclA+JPgy9TiZvG2MADLkAPzX5Xz3k7Pm+D20CFtzCy304WK
 2ZYyRG8vCNEQJifcHxxUWPdAJQfGkhrW2YW3zzjpxytQuxx2zWFOGTiJAnT7XatrO3wY7MEa5sh
 hEVdQ=
X-Received: by 2002:a05:6830:680d:b0:828:f59b:35d with SMTP id
 46e09a7af769-850fe3ff513mr7276627a34.22.1793058400262; 
 Mon, 26 Oct 2026 16:46:40 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc005bd7sm9509137a34.24.2026.10.26.16.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 16:46:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 26 Oct 2026 17:46:33 -0600
Subject: [PATCH 1/9] net: phy: check the first status read when resetting a PHY
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-1-e22389e4076b@gmail.com>
References: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
In-Reply-To: <20261026-submit-xpowers-acx00-ephy-mainline-v1-v1-0-e22389e4076b@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, 
 Sean Anderson <seanga2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, kongchen <3305708832@qq.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A failed first BMCR read can have BMCR_RESET set in its negative errno.
The reset loop then retries the read, discarding the error if the next
read succeeds.

Poll in a do-while loop so every read, including the first, is checked
before inspecting the reset bit. Return the MDIO error consistently and
finish immediately once reset completes. Keep the initial PHY reset
delay and the budget of 500 one-millisecond waits.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phy.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index cb4fba93391..1c894bde7d4 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -742,23 +742,21 @@ int phy_reset(struct phy_device *phydev)
 	 * auto-clearing).  This should happen within 0.5 seconds per the
 	 * IEEE spec.
 	 */
-	reg = phy_read(phydev, devad, MII_BMCR);
-	while ((reg & BMCR_RESET) && timeout--) {
+	do {
 		reg = phy_read(phydev, devad, MII_BMCR);
 
 		if (reg < 0) {
 			debug("PHY status read failed\n");
-			return -1;
+			return reg;
 		}
-		udelay(1000);
-	}
+		if (!(reg & BMCR_RESET))
+			return 0;
 
-	if (reg & BMCR_RESET) {
-		puts("PHY reset timed out\n");
-		return -1;
-	}
+		udelay(1000);
+	} while (--timeout);
 
-	return 0;
+	puts("PHY reset timed out\n");
+	return -1;
 }
 
 int miiphy_reset(const char *devname, unsigned char addr)

-- 
2.53.0

