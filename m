Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD2606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DlDxrzey;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gKg0Z4zF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24C4F6079B;
	Sun, 22 Nov 2026 02:34:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ONbQHjTyahvn; Sun, 22 Nov 2026 02:34:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 348DC6078F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795314886;
	b=Ciw7EWNwVKrNgE/WaHFRWdzLbdBEQ3oBkPhIgmNBvv4mfUMM4Oy8uESDHmMyas3g0NrE
	 UTtc09PnLTbx56tMWGOuIZMiuDGuICC1WowXpJTb0pvoazvSEN5vFElgRG7u6GEV0DyfS
	 xY1auE2LCL7h+cti9KmTva1KQiz6HlL6XO0GzwP3Votq8hm27XKopkmhrkD0lpBE48gsh
	 GdgV/6l24NzBFO+pjrrgjgqcYPzPpqySdfrpTWtiLBj49KW07QBbEqoaAqVK0RW+skw65
	 nnKXil2dqeWMzNHYrBRf0RxdcJ+abIkQ4YZ94DNAjC31PzNs/KkMxRPz1cFh5PpjKvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795314886;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U/PourdEA5V3jgdCGaiJgRiPrRPMqe2sBkZ0oGUaTVs=;
	b=De5ibAaWAfNV5wYYEKCfljYPJ8Tp3fhmx2BQtA2CXhMN5boq++/3NzNaIKTZRBlND3iA
	 UbfXefT/glyBJ4A0JzijKdsjRYPLyJedvF1sLIVwwDidFYtJArbE42Ojv2snMAgFLokj+
	 M8aSAuqbO5A6m6hmm8kE/EBt3vuMQ0U89T9MyETGSz1g9ig5rX2mFaPThlkWvdZkR9kRk
	 glrBYnApNHsShnTW0d1/fZkply7s3HX7ZGiK2lYkvwtQriUUgnsp5T16kh5OQUhyFQP5C
	 itf2OLlTp4VBapfaUmBcdA3PWNu2bvNhTmoSRjYTHAAfklUxJ82RE94f21iMq68otbQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795314886;
	bh=U/PourdEA5V3jgdCGaiJgRiPrRPMqe2sBkZ0oGUaTVs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DlDxrzeyI+Y3/hBsxzF1sRs1VsQ40fDFIX7eZvUrZa2CA3CerX9f5W7oVyJmCwW4I
	 yKzPuP98iyiofE/17u+XjK+yLiTjwJuyP6ixZmGYLYAS5OhtUqNnTV64EjZ7Hu6Q1D
	 WZ0faRMUrZahWHdTy+L5fuSTA8FjgSgd7Im9yqsYC4GR42HtG7amlLoCvnn8H+oO2P
	 X27REKrNgYJwQ6iAySERMm0hZCffTUH8NCLejaeR6hFiJSOf2x2yQTEOEmTjz3grFP
	 ZKNdCf5K4iTmwKaXiRs+kbxeACio/BffA8W/H8tCtSz9Kzx3sLs2zBtErkYQ2D6cUn
	 gq4rClRHtnshg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 348DC6078F;
	Sun, 22 Nov 2026 02:34:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 33DBB79D
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A34E40012
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y0pZw5LW4r2C for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 02:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8D1FE40176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=gKg0Z4zF
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D1FE40176
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BB2E4557F;
 Sun, 22 Nov 2026 02:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A926E1F000C0;
 Sun, 22 Nov 2026 02:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795314881;
 bh=U/PourdEA5V3jgdCGaiJgRiPrRPMqe2sBkZ0oGUaTVs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gKg0Z4zFbu5neJyrxkWweUpTN4m2tYErZtqQ/Xz5RhtxSpDRsqV9l30o82SiqCyht
 WKuL2I4F9H1uSnuu89btdcFDa1lEarj96GxRftkT7MZrFBB3ejQm/4xW1o5jpukNyr
 Ya8rZayxCHSVcm8fd1aq37G6AIEBfLCDH2XTTGopL/vB6PJeXOq8vyM3GtBmXyaDMj
 jLi4VSp6ZnH5RRBgvyecaMJTaihJGGgvpyeHTTb1CPUK/tQSEYVT6heFxZNMukiwvi
 9dBeBLE2w8j0c8Ku4HIuKD8O4XTWII5DbG/Bewa6YqCwvvBCqp+kQADlTfdfajocH/
 j/SUyNyRL7B3w==
From: Yixun Lan <dlan@kernel.org>
Date: Sun, 22 Nov 2026 02:34:12 +0000
Subject: [PATCH 4/5] configs: spacemit: k3: spl: Enable pinctrl
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-06-spacemit-k3-spl-nor-v1-4-33beb921011d@kernel.org>
References: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
In-Reply-To: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=699; i=dlan@kernel.org;
 h=from:subject:message-id; bh=1PxASOjCceua2o/gqVOFwrcEAK6xBYJzl8156pmWbxU=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBrAlSwSN0/RNsFDN8c6cyWhU3aeLAAFdA6M+h02
 erJNCUbdCSJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCawJUsBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3A/Q/+IsBYKQ3r14sbgEaMdCr/UVHnhrG0RdpmE8xlOvSskyt4oTQThltj8
 wkQQkG0LBFtLKiNJKn8YwoVP2AH+T2X4478Ht9+4TrYMlhklgeIzuBRXXOsDGSBVFNuzs0O2T/j
 A9iogGIW3FXh6s/INEnxTC89dwY9STAVEmfuVTtuhHQAs6NXUoINHxC4MO7NurM32FGiN+qGmq0
 lXLOg/uZSZHQafVhbT+tyASw4T+QUwpzIVPxwgcFmCJxq2O39niezrkmJhZzzGQQV0Uw8GGJhcy
 0qFisg0GmKtVogWIPJ2bP9Z+JuVrt2iU0wLmM59p7ZgFqV0rQihUAmCDaO/B4oZHXYu7mFkc+xd
 ucPL3qZ6x1UcsDZo0eTuOQQBAGAHjAfAb9tIWxlEK8yOVYbj8BJK1YI+H28lRC9URljVQONJ+wR
 xr/Z95boz4aRoTNU6VW3OH0hgYS9WDa4lsROH5aKrguoQClMIHLESpmNVkrjAVDCzt9mrrBXWJ5
 i+Yx9vo8arpBuXc0YSqxox5EjbOHs3qSM+SX2SzLhLeUHlp3FOT033GR6i2aXSEdOGSkFHuYaXT
 jesTHtOQCn3Am+ChVmCJINDCKHm6eFKbBxoUwJBEqxmb6B98s4vp8fTxOiDg3Gp71C/pJaYXaDy
 bup6tiZxijezI/FXlBCOLRN9PHpx8Q=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable SPL pinmux and pin configuration support in SPL phase.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 configs/spacemit_k3_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index 3cf6b13d7dc..9c976e83a48 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -75,7 +75,9 @@ CONFIG_DWC_ETH_QOS_SPACEMIT=y
 CONFIG_PHY_REALTEK=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCTRL_SPACEMIT_K1=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCONF=y
+CONFIG_SPL_PINCTRL_SPACEMIT_K1=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_SPACEMIT_P1=y
 CONFIG_DM_REGULATOR=y

-- 
2.56.0

