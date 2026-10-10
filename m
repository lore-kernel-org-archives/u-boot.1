Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31A9CA9EBD
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 01:52:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 989054093F;
	Sat, 10 Oct 2026 01:52:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVwZ71BcqmI5; Sat, 10 Oct 2026 01:52:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AEBFF4087C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791597173;
	b=MQlofBpSapRBs8fIXcWrVfQM6q7DMrgxfkTrKJxfb1BiSdbOGj8BjG9Bp2c08wUmZdef
	 uSsZB5k58DOgvdLHZnzC194GCYYcVxsvPtxKzpUGv6XrVefbCDdIw3UGHcfV/xKSoemMi
	 ylZeay9a7I5Tn+y2YWdD5OZ4XWVUiTH0q1AoGxYAfVw+/wDWYQMz7Umr/f+TkgOF055UT
	 zUfKlVxGJE48awLGS4DD1q0D4veSaRVWSeIAbHcJuB1TfuwAzTUscDvyYVCkRyfGbdXxp
	 S2kT3ejJvZ47v/XaQ5grOgkQmEsMkcD9cSYlot8x3/uj6jC7FPO81llaGLDFV3BwFWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791597173;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=b8VyvwGUWZgnuGhH2kpoemzvnQb+nix4qYjZeGdiHK0=;
	b=fX6VHvRiWgNCN9MClbYZpB8LVI2rEPcIoTxX3Mf7Hl2ZrsRtZKmTANxDLRt626wSqA0q
	 QqrR5zjZbiPlj0BkAFBBhg1A0hLidUv12yvjL3fdAYW2qPU5DHj05Jyx/aFn8VAAepGQj
	 2c1KS6GfDjD26CKsRdYxON3tv4q1mbCQq84vWwTC+0anWqXtlYM+oJtDNiExLDWCrTB4S
	 2eW8OZXw4kofRDAnqyo+aA5rImeN+Gwa5mcSVXWr3yYG7I6bpzJFqefqMJ9d2eV2+s5Xe
	 LR6xMpK2qZG6ZJTewIqKn3HZ7YYqtORWWBrh3iJ/pnsJeIFXQPW8ICcxJw7n1SIAgFg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791597173;
	bh=b8VyvwGUWZgnuGhH2kpoemzvnQb+nix4qYjZeGdiHK0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uM55qu4CE7c31nTfiNISAo2oHNdXwpyRsSyO6suXGhvSOZpzCAyPPzCXx3M1Z9FVU
	 wLly/E1QM75ZDSBMgl5HK+1TmVK0JSZ4+Bh89ioqY+sxP5DTwyrMvcq+Ov0Fr9oDmr
	 2HwPsAMhYHeca/WEmlHZCIp2f61hzmy+6ldM4d3XtZd5ix4pwroyNQCdWf8B7278av
	 q3YDJcbOpVT2bkYle7L7wXih0isS29I8fJHM3yaLKkZye5F1CGPH30BhDqJuDABiow
	 0KFZAIkAYMS32io3C66F8bd7iicIhIaiNPZxTH3SFVaVofiRhavMBORNJfIVC2Tqhq
	 GCFVZN/ZwGpqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEBFF4087C;
	Sat, 10 Oct 2026 01:52:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F02829D1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 01:52:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D593D81106
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 01:52:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id soCNuW_oYYcQ for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 01:52:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D68081105
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791597171;
 b=PB8C9EN/X0L5Qy9+Yz0UEalHy4sVnT7tnqIWDpuI/p9YqyPB8S6qwX6UGNPD7vn0oXe5
 CaE2Chq7E9I86BDzBcELaHQXh4mBFsoTAYu3s5uFYAcvO4aQG2E+iHIJtwgmevPQ+06Og
 LHUO7ZT3JpHpGiag4DA3IXlHcnDqewjC3z5wuT3ORJAANotV6K+mMQSxWj9V+WvvEag9h
 hogR+HJSAdh+R0SIV6cek1ytclW2YjvqObvMJYtYdfQhICdsWs1ID+kFHL9GRALWTqdEh
 UzVoc56j+S2ishO0b4Ri4mrj6sh4+HzNXEFWrNOM6g6lxWujlY1Vxzz6bJw73a7Sp0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791597171;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=b8VyvwGUWZgnuGhH2kpoemzvnQb+nix4qYjZeGdiHK0=;
 b=LT3gPjOxxiAeADANTV9rl404npGv6PgH4AX7Mfw89mAH4RCAedbxicX+hDPIkmQhVYB/
 fM3y6NyR0J8te7kM2tQe36ujJivh5EKXIp0I/JqUqcFMxU+AWN0V44aUi0AMKeE0ss+vt
 FFDT0OzO55REz29+7uElZGFyaCNDo8+fdg/Ykr3lbhDQM/sguCJJLggJTyDBsSR+UDSrs
 udmltNowbjqivXWUkK20Hr7pRWFb8orJBYjSrMFhpPGg6OZ7EnNWFYv9URyv8RK0kbhb1
 /oWP7HbGNlNSXjZPccAbVsj3SJ93yWbfzBLeGaWcCZkEhHWUMEek+yk2YamAZvszqbA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Krmww4GG; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Krmww4GG
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D68081105
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 01:52:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 61D1840B69;
 Sat, 10 Oct 2026 01:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF131F000FF;
 Sat, 10 Oct 2026 01:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791597169;
 bh=b8VyvwGUWZgnuGhH2kpoemzvnQb+nix4qYjZeGdiHK0=;
 h=From:Date:Subject:To:Cc;
 b=Krmww4GGxyxl8HPhS8SKwZv+wz6XAQB34mBE6HzEe7f20muhZ6aEmLcqjmvByqj1M
 GTJIV5xUYZosM95XqWZYqfU6pxyoFGroUCi7HXEkUynEmIFM6KChHPKN4fKWCmt/T6
 bkcSYIfRUU5cjMu4QzhX/v779LAgCnWK2zTqy1GxfBLSJkXcSFYy4qt8K4xQKh9wI/
 OzClAJyR6mridBjvyiOPUWvj5VHkXq4PJfj9m7yslE9Lc+yPHErLZjJaoQNMSWkM3b
 QNXU3GLKZhQxRUtkmv42GzxIfCeJPr6cH8CBO66yiJG9WaZd6+rY0FmWOCR0WR8Kvo
 /0RrmqEHstkfg==
From: Yixun Lan <dlan@kernel.org>
Date: Sat, 10 Oct 2026 01:52:39 +0000
Subject: [PATCH v2] configs: spacemit: k3: Enable Ethernet support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-02-k3-ethernet-support-v2-1-af7f55dcf207@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6DIBAFf8Vw7jawmio99T8aD4qrUhshgKaN8
 d8Leu5xknlvNubJafLsnm3M0aq9NnMEvGRMjc08EOguMkOON15hDhxhyoHCSG6mAH6x1rgAuex
 KlKLsClQsjq2jXn+O42d9sl/aF6mQ3pIxah+M+x7lVSTvjEgs/kVWARzaikTf9Cp68jEl4X01b
 mD1vu8/LpgCVc8AAAA=
X-Change-ID: 20260823-02-k3-ethernet-support-39d72917d42c
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, E Shattow <e@freeshell.de>, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251; i=dlan@kernel.org;
 h=from:subject:message-id; bh=HNgfI0ITaHqMMC0XEGh9fE+g6mzvtdX4E4O2kC6paLE=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqyZpraR32GKyXlEzw+n0Goipv8H+GUPlzMHIpH
 BcMVkWxebqJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCasmaaxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0fow/+Pn7UW2XJ1fX47sdh/BMCQQlnZCJPFIe29RG1yl3gKQ3YH/90rKWru
 aDkuG03mViMjsJiT6PqZsLWybaZtYv8bW2R2xlg1uimWjCEqoDZfGXWFfoOaqejybIeShmkmD/n
 nwESKW2RKY6lRRuqGtG4dMO03M3XPMBbgiR6ob6HslbM3WwMU29O224p/eQAf7uaffLbOH5MdC+
 bGDXWKSLe6m0qx0k2po8ybYXThM70540dfPVKI13VY/yrL6JCoZ9fRbcfVUAdRa0OhUwl1yqT/B
 uOsoIRRKu5MVW5P+mYb/GtmXe8YmjUwmoDdWHmT3XHUzMxRSq/9zxkCRTjL2oTcIDNm1IOKGf9G
 9iYTrROI+WYFyZKNT9Zk5t469clUgDphKw370X9mzvzm7AwaUVhBUzZGq2CHk8DBSg6Cv2qP82W
 Fy5J/ZYBzvo1B0D51zZS2E27S1rMvolriCH/dE0cuNyuI5Vcjm8JMEJlzPoyr1JbxzfL50i3A6+
 dCxx27344udjq2IHdMaQRo77kLjelpT5j14VLFqvCx3axipGHFA9Sk4b/GQFxescT+Oh9U/XTVN
 rYiHzpI9A1XTEdoddFp1WR/4xQ732abl3LeedfvbGWb7pVJYbGcXukUU6CFLT9yxfWAAYEMMCcS
 SVH30hrreZ7SqUNJUWAHImI+tiWgZo=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Enable the SpacemiT platform glue for the DesignWare Ethernet QoS
controller together with the generic PHY framework, Gigabit Ethernet
PHY support and the Realtek PHY driver.

Enable DHCP, MII, ping and PXE commands for network configuration,
diagnostics and network boot. Allow U-Boot to generate a random
Ethernet address when no valid address is provided by the board.

Verified and tested on Pico-ITX board with commands of dhcp, ping,
tftpboot download using md5sum check.

Tested-by: E Shattow <e@freeshell.de>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
This series try to add a Synopsys DWMAC glue driver for SpacemiT
K3 SoC, and also enable ethernet support in the defconfig file.

Tested on K3 Pico-ITX board with command of dhcp, ping, tftpboot.
---
Changes in v2:
- drop dwc_eth_qos patch which applied via net tree
- update config to enable DNS WGET NET_LWIP
- apply Tested-by tag
- Link to v1: https://patch.msgid.link/20260924-02-k3-ethernet-support-v1-0-b8e1fafc9249@kernel.org
---
 configs/spacemit_k3_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index a6d1f35a93e..586305c6232 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -24,11 +24,19 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_WGET=y
+CONFIG_CMD_PXE=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
+CONFIG_NET_LWIP=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYSCON=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K3=y
@@ -36,6 +44,11 @@ CONFIG_SPACEMIT_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_SPACEMIT_K1=y
 CONFIG_MISC=y
+CONFIG_PHY_GIGE=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_SPACEMIT=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SPACEMIT_K1=y
 CONFIG_DM_PMIC=y

---
base-commit: 9de53bfd71f893b25e44a747ac0b0612e1b27c21
change-id: 20260823-02-k3-ethernet-support-39d72917d42c

Best regards,
--  
Yixun Lan <dlan@kernel.org>

