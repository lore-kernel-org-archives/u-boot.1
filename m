Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255EB606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VhvLAqay;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=WbOCnL92
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01A1E810E7;
	Wed,  4 Nov 2026 09:48:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0823L9Tu9qRn; Wed,  4 Nov 2026 09:48:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 80935810AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785731;
	b=d0ZJ5hfC18HFK7PDAvHwmOxemg/yxcPlE/4xUtYHj+B6tvH/sx6L32QUJ+tXQg0MwJfO
	 V334WuxgjXk68rp3XD4GETptBWM9PYWssVdMxJWFw7H+hORlYCoD2/D9hDUZdUx5SriY6
	 oxTP22sgrFGJw3kVEgcMEfXlRs7WMm0ishOhpy9wN0DBQgCnJPt0MaBIH4DmS9Kd+Jx1W
	 nqgozNwZ8iYc3CsJ1sNmKVU5VadWVYA5AtM/SnfQiCctRZ1pfjIvMt7Sw62YFbZ2iqsUY
	 Qgxulk0SL0euOwxSSnE3mhX0jY5ymlc5nCcVdOrC85IF95x6UB7GXK8UGmQAr8XFLtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785731;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1+txNUlCaJwcx4rBeRVNv79gwe6bN3ydt7/9ra42gPE=;
	b=cB4HJIcrvNP3fkMcz/FR04qDYaU8XsokqMMgyIqjW3tbRdUPxiowJyZuhoQHYHykgy6N
	 rWPcPf8Ax1HCJ3LPEAWiqEFXIJWYNww9UG/zBeN33Mo6bGdYmKa0S5DE3NacoBRCRT5gz
	 8zlbwzQYr2h5IcDim6uIXe14rMA12a503jlV6W56Jr6HIKkNQgpOH5ATLRApSoJaqB9PV
	 zANJpMcamYnj7ajYIqaX8Kqjez87bQlN6WyZvo7mK6wuyjhUdowcsFthpp+C9vgodGFYa
	 i4cksEOzS/RX5s5EPTcQV4q/cn0hxT1EUPx4+RsAt7UkhAIOy54trbAnNY9Hh9KA2Nw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785731;
	bh=1+txNUlCaJwcx4rBeRVNv79gwe6bN3ydt7/9ra42gPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VhvLAqaybO6LijadrXCy1mS6sEM5VrU01y0udwplFtq2GRFNut0E4w+qUdGCDSu0A
	 ogGX3HZMRCTCWfCLF8hQdPRtVFFRhTUJHYEVO4T4zMsfnmephR+5syMIC1GOPtOHld
	 +N8KOIcroJGcxPBLuH4MoGYvmuWnzh6Pl+zl9uG29t01TBM9/tVOMgXg326xDWkYN2
	 4pgSg+9NiQxluxvVP8YOqM/osvtSjuKCcN7cMsk9nypfqMubgisVRKu3PBNG4gKeul
	 6309VEIElNEvFkK/q1M9Cua9Y+H0mE748czploIxacUOOr0Y/+Hg+uz3TwNpo1NGGJ
	 pBCy1aofOLv8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80935810AD;
	Wed,  4 Nov 2026 09:48:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30BC837B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BFD74076E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4D1RWjVpXrB for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:48:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5160E40652
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785723;
 b=Ns3x/jBfK0O3yk8at9tqIBKLzg6aXaPFbkB4O3WzMmq2NkwJAnXmA6pvKma34BwXCL6g
 2jqAjmAyPKpS6jT6Rgb7ZjemoK5LVxJpUZoY+t89GbEza6hlEjypCa8Mj7aJsBbzu1MY4
 BDKJW6B4Yupyup9weSpqbAkaLACIxM8KYn15OnYzQvyOjEzqzE4GuHLH4yKVU1bANM7o4
 Oc3sVzknP94O2VirMOnrllFPZcwMTOw+G+Go3jUzJl6gLWJvjxp5PDUk+c7I0ScPJZIYw
 RDmfeomrk8+vQcGUgNEE4pwbyHSqIpb/sGUynGVIIuA9f93FtgcHPPznM9TlPdm1ZuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785723;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=1+txNUlCaJwcx4rBeRVNv79gwe6bN3ydt7/9ra42gPE=;
 b=ShgrVUNjl553qaSco4bItxfqU3iYKPebO0Myp2SlYJ3Js8fvGGuRfStd5AUvEhGTxeuw
 uLCwD7gj3FjGdNTCoDXYRLnktSLzSctw0CZNrvyD9uvxlBK3I/QHOjc+H4CWlJUtiwdr1
 6CDUx445KeXxdcO0BtCuUDwpCARbaE0ctPr21E0gspegYOL4rFK0mzc11ZTL+yLtQ7ZdS
 RbZOqfbkIaNNmybALk7RB4keaGt7AuTA0Jb8wvMGTqS96sHuJeSrR9ZGuvhwp4G7z9Doo
 55tZMgDqaMLiNw9Ybs16iwfbWc09yV5Wdq+87k+T4YR0I1Y+8AahF71z5zNMhqmykSQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=WbOCnL92; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WbOCnL92
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5160E40652
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:42 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so2947155e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785721; x=1794390521;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1+txNUlCaJwcx4rBeRVNv79gwe6bN3ydt7/9ra42gPE=;
 b=WbOCnL92kjEHIlIcfaocJDSIIPE+TKJgPQivHBWMErUsl8B8uNeNhDoPsONIaADKZ2
 9O/YPOH7CUnhc5DOusYZxo1IEp+Z01/nBSxARRs1VSqB4D51tiktub8A8yruF6O/XS7L
 cd5lk7kuz++vPq3glDEu1AejmZQRzgYbVhUgYhzx0MeoInPZhTW4kRjDtdAicxq6JSMB
 5EDVXu/1X9KM06FGleupfBQAe9qe3/ym2fhf0KBFl0SopZbJw7mAwxEiC6tkGiTni1u7
 QGF2KOAij9tNpAjg1gEBItZHOjoIUXcCOkQ1N6a9W7bBUrZhIeRCPvRNVtray9NicgpN
 /Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785721; x=1794390521;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1+txNUlCaJwcx4rBeRVNv79gwe6bN3ydt7/9ra42gPE=;
 b=Q6HkquaEJuTnY4AWE55wa9kfjsXNk6bhJTd9ncB21jbewulmaqzsr+5rBhVho59AFv
 5Yc92Yb8svoAISVYI5SISN/H9eiCMbD+ugwuckwuhYAE2UctAtULXLFnS2IyJmHQN61V
 /AzWXsW6+1+vf7GqfvzeV5nGu9r1qLuLTeX6uXfXZAfd/cD0QyOZZLks3oxzSd8PqRIl
 5pddtM6MVW6pFRXokiesKdz8NEKdY3Xi+O0osI+PVzhmA/cun1TmgYhZ2Pd1SRNZ9/0F
 qbzmHUPLV9427q+W+o2+bj3HZH0xq6mO5RhagWkpL0Nrlv98qTJHvii3/BsP18b4+nlW
 q0Qg==
X-Gm-Message-State: APuU4Z8Wmgkb/c/e+vlI3K/b5aQkcknxY2OV2Wvpfb/z48UDK21lZG4n
 VsW1tGgys0iEVaVjTqcJGCMa/QZOOS7I45xjEss476Q3SguIoSev6uORftDFy2dXw4E=
X-Gm-Gg: AYBFou37/D4Yh59uMqJSKcPoxTLsv28Mzsk1UoBJVzohhCtoD7akQOJPgH4VtD7tYUm
 954hHNCq4cqJDmDPdwEftrRYyLUkBigAvmlz929ZLnMEHGosPmx/2Mv2uzQc6SsehqA5K2JKHWu
 gPFKVlB6TYLvHjTqweghZRd7assT+Hp70ThLEDF+Pn27fbVm2fpqBkWxZ6d0wuX9CWVWDRHFMvJ
 3hHeplEUU+tH/nvTVabdADvVj9/gamqkkHjN4oF+cp0SRzJaSddmDhKBMjNF/UgiDN8RUVvcCer
 JoKBhndO0xRi2MrGq8w+rpFXbfkdL8Mn3eyNS3tJ2tZcBu3mx8tywRpgMfPB78KY+KOAreXisya
 QZY/LfSccpN6DJReVX2cSlfCofhHaKGMimjsvHmbZxwZhUqQHFxo2aYkmhuIjec1yqp9ZWOD0Bv
 4MzLF1hLl0pqkgXOccjVNpqfVUC+vOMH9MT/hYFch/KCWSXkep7jJOsym2di161M0Aw5XFe1E27
 m8Pq2Ma5TeE56aXR+wWk/9Qqedp4CDzCknKyEA3CbSV0/viEeGNutruGy/s+zV1Okclcj1MBAOd
 W7R2mTfCgf/4fqwY9wJoUI6mBQ==
X-Received: by 2002:a05:600c:1909:b0:4a5:26b8:4507 with SMTP id
 5b1f17b1804b1-4ac18b7dff9mr353483455e9.21.1793785721090; 
 Wed, 04 Nov 2026 01:48:41 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm174395795e9.13.2026.11.04.01.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:48:40 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 04 Nov 2026 10:47:53 +0100
Subject: [PATCH v2 6/7] configs: am43xx: Switch to upstream devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-6-6091edbb51fa@baylibre.com>
References: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
In-Reply-To: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18530; i=msp@baylibre.com;
 h=from:subject:message-id; bh=01AohpCDvR+oovT3ls09Z+juHxmLEEllwK9HRHiMHao=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqxX/1PONUW6bnHbJttg353OsfHd6rKqGJssJSPzF388f
 CNysz53lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwESazjL8r7xSPEdH3MnKw3aX
 NK//v3fWTpaSfb9T/8S++7f5qkr/X0aGv2I9y3csyny0UyNlsf8bn2aTpYz3mD1nNR1SPpfwxO0
 wDwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switch to OF_UPSTREAM using the upstream devicetrees instead of the
uboot ones. This change requires updates for u-boot.dtsi and defconfig
files.

*-u-boot.dtsi needs to be updated to reflect the new label names of the
upstream devicetrees.

The defconfigs need to support multiple new drivers/frameworks to have
the boot working.

The qspi variants have no SPL config options enabled as the boot ROM
executes uboot directly from the flash.

With upstream devicetrees i2c0 is within a ti,sysc device node and
depends on clkctrl clocks and PRM power domains. The QSPI configurations
read the board EEPROM in U-Boot before relocation. Mark their nodes with
bootph-some-ram to be able to probe i2c0 before reading the EEPROM.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/am4372-u-boot.dtsi           | 60 +++++++++++++++++++++++--------
 arch/arm/dts/am437x-gp-evm-u-boot.dtsi    |  8 ++---
 configs/am43xx_evm_defconfig              | 22 ++++++++++--
 configs/am43xx_evm_qspiboot_defconfig     | 14 ++++++--
 configs/am43xx_evm_rtconly_defconfig      | 22 ++++++++++--
 configs/am43xx_evm_usbhost_boot_defconfig | 22 ++++++++++--
 configs/am43xx_hs_evm_defconfig           | 22 ++++++++++--
 configs/am43xx_hs_evm_qspi_defconfig      | 14 ++++++--
 configs/cm_t43_defconfig                  | 17 +++++++--
 9 files changed, 169 insertions(+), 32 deletions(-)

diff --git a/arch/arm/dts/am4372-u-boot.dtsi b/arch/arm/dts/am4372-u-boot.dtsi
index 67a1b5ebd6e2..2b18650e720f 100644
--- a/arch/arm/dts/am4372-u-boot.dtsi
+++ b/arch/arm/dts/am4372-u-boot.dtsi
@@ -14,14 +14,6 @@
 	};
 };
 
-&am43xx_control_usb2phy1 {
-	compatible = "ti,control-phy-usb2-am437", "syscon";
-};
-
-&am43xx_control_usb2phy2 {
-	compatible = "ti,control-phy-usb2-am437", "syscon";
-};
-
 &ocp2scp0 {
 	compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp", "simple-bus";
 };
@@ -42,10 +34,6 @@
 	bootph-pre-ram;
 };
 
-&am43xx_control_usb2phy1 {
-	bootph-pre-ram;
-};
-
 &ocp2scp0 {
 	bootph-pre-ram;
 };
@@ -62,14 +50,26 @@
 	bootph-pre-ram;
 };
 
-&am43xx_control_usb2phy2 {
+&ocp2scp1 {
 	bootph-pre-ram;
 };
 
-&ocp2scp1 {
+&prm_wkup {
 	bootph-pre-ram;
 };
 
+&prm_per {
+	bootph-pre-ram;
+};
+
+&prcm_clocks {
+	compatible = "simple-bus";
+};
+
+&scm_clocks {
+	compatible = "simple-bus";
+};
+
 /*
  * Some boards boot directly to U-Boot without SPL. In this case we need
  * support for reading the EEPROM before relocation.
@@ -77,3 +77,35 @@
 &i2c0 {
 	bootph-some-ram;
 };
+
+&l3_clkctrl {
+	bootph-some-ram;
+};
+
+&l4_wkup_clkctrl {
+	bootph-some-ram;
+};
+
+&prm_per {
+	bootph-some-ram;
+};
+
+&prm_wkup {
+	bootph-some-ram;
+};
+
+&l4_wkup {
+	segment@100000 {
+		/* PRCM */
+		target-module@f0000 {
+			bootph-some-ram;
+		};
+	};
+
+	segment@200000 {
+		/* I2C0 */
+		target-module@b000 {
+			bootph-some-ram;
+		};
+	};
+};
diff --git a/arch/arm/dts/am437x-gp-evm-u-boot.dtsi b/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
index 6393170ad22e..0574abeb7a2b 100644
--- a/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
+++ b/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
@@ -23,19 +23,19 @@
 	bootph-pre-ram;
 };
 
-&mac {
+&mac_sw {
 	bootph-pre-ram;
 };
 
-&davinci_mdio {
+&davinci_mdio_sw {
 	bootph-pre-ram;
 };
 
-&cpsw_emac0 {
+&cpsw_port1 {
 	bootph-pre-ram;
 };
 
-&phy_sel {
+&phy_gmii_sel {
 	bootph-pre-ram;
 };
 
diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index 743ef0a88f2b..aac7d0d46dda 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -6,10 +6,11 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
@@ -32,6 +33,7 @@ CONFIG_SPL_FALCON_BOOT_MMCSD=y
 CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_CMD_SPL_NAND_OFS=0x00100000
 CONFIG_CMD_SPL_WRITE_SIZE=0x40000
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
@@ -42,7 +44,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
@@ -52,10 +55,21 @@ CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
 CONFIG_CLK_CDCE9XX=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
@@ -75,8 +89,12 @@ CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_OMAP_USB2_PHY=y
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index e612dde93ee0..73f7ac29e027 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x110000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-sk-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-sk-evm"
 CONFIG_AM43XX=y
 CONFIG_ENV_OFFSET_REDUND=0x120000
 CONFIG_DISTRO_DEFAULTS=y
@@ -30,7 +30,8 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-sk-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-sk-evm ti/omap/am437x-idk-evm"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
@@ -42,6 +43,13 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
@@ -51,6 +59,8 @@ CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_PHY_ANEG_TIMEOUT=8000
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index e4102c902485..06fbd2401ee5 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -6,10 +6,11 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_SPL_RTC_DDR_SUPPORT=y
 CONFIG_SPL=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
@@ -29,6 +30,7 @@ CONFIG_SPL_FALCON_BOOT_MMCSD=y
 CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_CMD_SPL_NAND_OFS=0x00100000
 CONFIG_CMD_SPL_WRITE_SIZE=0x40000
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
@@ -39,7 +41,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
@@ -47,9 +50,20 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
 CONFIG_MTD_RAW_NAND=y
@@ -65,8 +79,12 @@ CONFIG_PHY_GIGE=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_PHY_ANEG_TIMEOUT=8000
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index bbf57a8ed797..12891bffd7b4 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -5,10 +5,11 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_SPL_TEXT_BASE=0x40300350
 CONFIG_SPL=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
@@ -28,6 +29,7 @@ CONFIG_SPL_FALCON_BOOT_MMCSD=y
 CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_CMD_SPL=y
 CONFIG_CMD_SPL_NAND_OFS=0x00100000
 CONFIG_CMD_SPL_WRITE_SIZE=0x40000
@@ -47,7 +49,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
@@ -59,9 +62,20 @@ CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MISC=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_MTD_RAW_NAND=y
@@ -80,8 +94,12 @@ CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_OMAP_USB2_PHY=y
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index af93fecc8e9d..79c57f017528 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -7,7 +7,7 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_TI_SECURE_EMIF_REGION_START=0xbdb00000
 CONFIG_TI_SECURE_EMIF_TOTAL_REGION_SIZE=0x02000000
@@ -16,6 +16,7 @@ CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_TEXT_BASE=0x403018e0
 CONFIG_SPL=y
 CONFIG_SYS_MEM_TOP_HIDE=0x4000000
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
@@ -33,6 +34,7 @@ CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
 CONFIG_SPL_NET=y
 CONFIG_SPL_NET_VCI_STRING="AM43xx U-Boot SPL"
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_NAND=y
 CONFIG_BOOTP_DNS2=y
@@ -40,7 +42,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
@@ -50,10 +53,21 @@ CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
 CONFIG_CLK_CDCE9XX=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
@@ -73,8 +87,12 @@ CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_OMAP_USB2_PHY=y
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index ad84ee36cc48..8b74e9a53914 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x110000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am43x-epos-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-sk-evm"
 CONFIG_AM43XX=y
 CONFIG_TI_SECURE_EMIF_REGION_START=0xbdb00000
 CONFIG_TI_SECURE_EMIF_TOTAL_REGION_SIZE=0x02000000
@@ -32,7 +32,8 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-sk-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-sk-evm ti/omap/am437x-idk-evm"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
@@ -44,6 +45,13 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
@@ -53,6 +61,8 @@ CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_PHY_ANEG_TIMEOUT=8000
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/cm_t43_defconfig b/configs/cm_t43_defconfig
index ba898b119537..fe2988243d9e 100644
--- a/configs/cm_t43_defconfig
+++ b/configs/cm_t43_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-cm-t43"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-cm-t43"
 CONFIG_AM43XX=y
 CONFIG_TARGET_CM_T43=y
 CONFIG_SYS_MONITOR_LEN=524288
@@ -23,6 +23,7 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="mmc dev 0; if mmc rescan; then if run loadbootscript; then run bootscript; fi; fi; mmc dev 1; if mmc rescan; then run emmcboot; fi;"
 CONFIG_SYS_PBSIZE=1050
@@ -41,7 +42,7 @@ CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_DM_SPI_FLASH=y
-CONFIG_SPL_POWER=y
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
 CONFIG_SYS_PROMPT="CM-T43 # "
@@ -63,6 +64,7 @@ CONFIG_SYS_DISABLE_AUTOLOAD=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
@@ -70,6 +72,15 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DM_I2C=y
 # CONFIG_SPL_DM_I2C is not set
 CONFIG_SPL_SYS_I2C_LEGACY=y
@@ -93,6 +104,8 @@ CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_PHY_ATHEROS=y
 CONFIG_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_I2C=y
 CONFIG_DM_SERIAL=y

-- 
2.55.0

