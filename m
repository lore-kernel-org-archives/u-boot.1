Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEC0C9830D
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 01:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FC8260B55;
	Thu, 24 Sep 2026 01:53:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RQH6dqumVFMR; Thu, 24 Sep 2026 01:53:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4BB8E60B53
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790214836;
	b=qN6miU1DifL/VBQzup+/PnmeJ4DM5x87PNCC2ge812dbs5JY4eBT2NjndUg4tmOdCQAf
	 koi/lPhh0kb6cgHRA9PGJtU/XwUdl5ipvXqrzDyv0Q7UP6TPD/ZXs1ildIY1v2pL/YiMk
	 gnYzuDPUrOsiTB9gTmvnuRkbU5W2KmE6JqtF2AJJtsAWPnRh8U1Z3Pd5U8jXnsBsh1ajr
	 yQRXNXqO3OlfLM4YGIW34FStPanB1EbS3meSbS7PqQfIJ1MJeuLQBQkE2sg34CSQtb+pt
	 Kaw73C6CSjesC+SbgU+Fsg9NEcsM+M76Ecik7izL3CGV6zhbAXmyPV0f88r+7PXNX7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790214836;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KxUZgygbD6pzvkbZMV6HMcwciRjDi37XPGhTsTHCYgA=;
	b=nnG3M+FSpIalqSQYAf6KZ3OI3EeMmFno+HC2Vc/MLp0yZcWeT6LmDR6lxzF7G4hLSkvW
	 s66GBD9GWy2faDu4kFvTww11ryd+hH+8XiRTELQfHgiy0bc50TBYQbsqVY7vyeTExBLxs
	 QqXb8W7+DVi13oKSvJMZjJOQeFJEg18mAxffjuLKf81LOxbjbCyFuDleUJ28RQlpLyt2M
	 q32mbXKCiCd737kA24Bl985NKs61xN5xQQxZJeKP9LTAa5fEuzYV1rA5LJtv9E4vr5l44
	 zC3ApAn5CiFYRykDAJCxNjzjKfXmi5mP+jMQx9zWsThQ/0LYop/9jHGxJxGpEes50sA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790214836;
	bh=KxUZgygbD6pzvkbZMV6HMcwciRjDi37XPGhTsTHCYgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t7yjkL4KfNh0tFr4efEtM8V+/7ThDNgsQ5mNheH5eE+SUvkgXBKng9Y1Q7FIhkxPZ
	 b2OU4Wbh4Vb0zBvpvyqlslc9wfVAMP2Q68ZHn19I8dkyR8opVQ1wufYQqCb/A4beUw
	 x9nc/+YrjI7UzvKD3uTf5ycyQswfG7u+o5zrOQi0ogkkxySmspJa2waGaroOsMlkrz
	 Fak2oi/A9e9eX84exDhGxurBU/pcCAh3etAr75hlGDrAo/X/oC2SBXEAyMPgYkpAAs
	 hCX6FooCJVb3U02OzWvfmHiBaCRD+XZWOIIVEXBY4e4LDzmekAH+enyuYUiW6nUaAS
	 EiUCblckuKCrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BB8E60B53;
	Thu, 24 Sep 2026 01:53:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 181591DBA
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F293B40E78
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:53:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rhh-E9R1uwNJ for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 01:53:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5AFC440E74
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790214832;
 b=S+bspEnDnNeA6vjRUK1VK5wtuVoeBKdbhpKTvr4QHE2KNB/XAmF16y6T93WrVB+F0u7I
 QJLDgo4vM0Q/DeECsMiy8tAEgzYxdXuCkHb+5vGr9MaAWM8Mysl/+jufLqQe3fBSE7PH0
 E4vdAAigswvYQTIzRa4VwEHBuu3zrjzjNPpgwSPUCgTEHedTR5RvktAUXX8f/mldfBE9U
 O9faNcZalo0ezbPiMGjJJorNVrRKamJ26kzW3S4t3pXck8mWXgE0t879Oc9LszGgkq5/O
 3+gv+9UgGqM/Fj93QbhhNrpO6XSjaGkqed1wQkKgIfrJx6aB8dBRuAWqVTgqCHpDPOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790214832;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=KxUZgygbD6pzvkbZMV6HMcwciRjDi37XPGhTsTHCYgA=;
 b=hev94g1C/mQlbATbH0Y4KSWv4l8bt+uGTTt7uGM10MAujHDhsVMtJcJ1xSIOD4PQswg7
 b/CAhSWKnRyJ8MqHxfqIUwWafjJLCvJW1EBVTdSivvcg+E4DZYWzcD6a4N+WU4dj46XOk
 TR6O4p0H+X9BYeI332M6ZIH9TId4+3EAsn4QfVd0RUcc2309neslVMQqPRq9zGliHdaTp
 aPJ+hMXPD3Ya2g5He2a5hA7oIk3Aa3cGQqyXZ8+LJcNljFjalnWrzstUYidQHKifgxxmh
 Sn1eZZXwDODooeXNvqLwNex6aSbwE/e3//TuIHvm4eTVqdrmn2i+DbHodW2EN0dt3qQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ceYiUCgr; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ceYiUCgr
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AFC440E74
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:53:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 01FC1429D9;
 Thu, 24 Sep 2026 01:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC251F00898;
 Thu, 24 Sep 2026 01:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790214831;
 bh=KxUZgygbD6pzvkbZMV6HMcwciRjDi37XPGhTsTHCYgA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ceYiUCgrJITmNNrEVXD3qYj0kwbR8w0usHRmmukZPbplH1hnJ+m1cRLQW9R7k3xjU
 tSaRX38x2bGIfcQW31uoyxGvxEUz1k9zAbYUht2fkkTz3Gdd24Q3JtzAbuzzvviUXX
 z1BfbPJlz9sf+Rx1Fv142OyK75qcQGbNwD9Df4/OXmml2zGyHjL/p7z1GWeUNIt/AF
 E2QDdh4UluHQ4GfDJHzXnX4bb5LNxZNxvUW6F0qrJwm320tZ65BOLgg80DST8BEmBR
 jmtqKYVSuc9rijbN/xedRNki8Et/jCr+FSKmUCW9rwjSHVqJTw8rw2ot3l1ZjOIl7T
 fEHwQGVzdlGXg==
From: Yixun Lan <dlan@kernel.org>
Date: Thu, 24 Sep 2026 01:53:30 +0000
Subject: [PATCH 2/2] configs: spacemit: k3: Enable Ethernet support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-02-k3-ethernet-support-v1-2-b8e1fafc9249@kernel.org>
References: <20260924-02-k3-ethernet-support-v1-0-b8e1fafc9249@kernel.org>
In-Reply-To: <20260924-02-k3-ethernet-support-v1-0-b8e1fafc9249@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, spacemit@lists.linux.dev, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381; i=dlan@kernel.org;
 h=from:subject:message-id; bh=ZGYsc5FFTMc0cXDw8M1XksRbve//31AZNpv00afVkko=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqtIKlrTaG4KKAcsHFqZoFWcKak7yTQh80DLd87
 Zj9X37qE66JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarSCpRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2ZZw//RGsAHTpetOHqIreh5EztgoniqzleooqR2xWsGGoUfHHbVeYzYXDm4
 YUuJKQnTTWg3K6A9ADZecxpQv/RG68MVt/k6jmmHcUB5E5806znhuPGGZD7a7GRtQccztH1XD7p
 DRFfrStASytv/UE/OCddDBDj4lXZGYWEREY2iixoO3SfDlqfP6XWYCxfIl2ADIHOLb84wteYL+K
 ce01fXvPDXrPSIkXNwiu8fQyG7afpd/MWQNrGy1jojStXbwMcwnfjvBjWHVkhFyrC7xyK8qKYkE
 3litZeBcN5+QaWPrxAPgYgInDUAJZFc1JWlx6h1X1cX/tYawUh2zzlh6yttHoi4EBin1R1l+ajz
 htfgHMnZ9mqPRDma8NLziuUDd0JxlsUcJi2UQbHDEv7ny+BCaw7mXFzCPW6EpGbNyt34ax+BuzW
 224IUedtAtuM0Q4kC23eBDhe1h1z7f/NPN4DCz5XoCF5eg8DxiKWt7rutmgJzX6w9Sm7feNm2md
 AF4rAHmoq30TMYpb0YlI4KVSUi21juuZlBcSLLPZpl7AjRwGH6oUPt9IcRMA9nQUvtX62TpJ2BV
 RSpxlQlv5T1ve5yvbIms8Vxd83abgYjS1erKyA1ODFzPiLiM0ibYvVEH+2ks91aW9agMOvqjM8i
 jS/QDj+aHd7yIGSEKatZDjaVj5IV/4=
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

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 configs/spacemit_k3_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index 6ca41aecc41..3a70a0a4858 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -24,10 +24,15 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_PXE=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYSCON=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K3=y
@@ -35,6 +40,11 @@ CONFIG_SPACEMIT_GPIO=y
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

-- 
2.55.0

