Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37111CA5FE3
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 00:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBB4E60650;
	Sat,  3 Oct 2026 00:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4pQh7z8v6wzU; Sat,  3 Oct 2026 00:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1F46260653
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790987729;
	b=Xk4oeJF68NmSuJ+HtGzFViJ4QMLMX81x9VO+CtHoeeDjHdiAyDCslkR/rk/1BDGQ/DrR
	 HeZdGPDBHoy/Fu9XyYa+gv2TxkuEqcl58I+F82gMrOANIjlr1Y5wNI19BDS6IkU8tpdkL
	 29It8tJZaPWZFfDvpVwmNEeSXJ/GC4J8YMH5jG77eXF4X/96vq3Gd5MsrOJmWzXF3r6ig
	 ubiH49pkO3XiVwLHnwtISBYs/vCD7+JRQoPpSlOcia6kNeZT1heai/D6Bbr1rdb9mUg/w
	 ALZn2NPVtIoVdJxYKt73k043KPo4Nu6pVawWnjg3WGWAwKv7ygAQEO9b+1lKooEGzDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790987729;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t1p0oLFypoP2g6fx+M2RN69rNBfCYn1u5uYri41dGx4=;
	b=UzHUm1lwL8m37MP3SmjZ57KxpmkrG/GHwx+xDPxG58efiLaxp2EjtlCdHPaWqr01JMNE
	 zdRTfloSJEE9R/KZclTT+xVR/qhVRCwnGHHiRlRrtcf3OjFqYDt2kWC9V6dLG78ZABQwX
	 9pb1K+LgYkpasmY7lB7zZby/4c9z1W3AvIYOvPA0pz5uV+hC4hLXSoJ9k/eBPSLTPR8Zx
	 fSzruwqhPw/ZNIOFTu65oVvqXmyduVjdqoAVyD29XyItmFY/GiwJzuZaBtCNFJm9NX8D8
	 44WmoHKUt8xkfBTTD+MIiklH7wN5WxSkPPHVMHuk1ErEVCOrSfNysakB+GHe+fqvq+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790987729;
	bh=t1p0oLFypoP2g6fx+M2RN69rNBfCYn1u5uYri41dGx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EdCVyv/t8OyvQNnXR/5HuST5WGBRnqbUgY05B97Txgs5ig0pABnDVKt+BbscZWMs0
	 g5Xmd5SIGCg+xxz5BNTpmwBHxCmQB23tGRqbsV4H2Csv5BR6sAY02CMlbvQEV2a+gm
	 rDe/0uoik0H6cnTOouMoNasMcsiIh6qp43VYoUIpTBiL666df2ohxATR3K08uBYHaj
	 GaezfYHjo7rwOg+l3LivXr80VhqOmYMMjZd3eiLTE8Akyd6+BijX6+70cFdi65B0Jo
	 6qwxq/yFbFq5NexR1PbLGDCmPzky8NHhSrvF4Tq1tGfqyIxmlzjCRPsgxrAIus+7nC
	 e26Q73ZRVMxSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F46260653;
	Sat,  3 Oct 2026 00:35:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7522A34D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6657A40D83
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L8fO1XyvBNUt for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 00:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C736640CC5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790987726;
 b=FTJpbDbwuv+D/66P4ZK3ZSL2irSw7xjBDrkrEbf91F2fzNFJLA1uGU8YlBk3Dw+iuhIL
 g9CIMDg2iU+j4Ffg4syVQtQq/0ZZEqkf4Vt1cI20iqGVIqX/pN15TJ0/40tmnFH8Rn8M1
 j5Os4xSqIx/uX+S7IjP+X8zUu9j+EMZwlvkMi+0KcAADiq5ZDqOazdoWfkU+IIB+318bN
 XmLNPGVwGi8GIZLXN06KmO9QtgakXJyE8+CwEztlqJIjxY5O6H3NAUeEIr96yJsZn+o87
 3CGNNhOBlWJ2z4j9zngOTYNWLrvWCM6D8DOs4Tcz1WdAu7JCiRfjTv9dfsUqNSvs34w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790987726;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=t1p0oLFypoP2g6fx+M2RN69rNBfCYn1u5uYri41dGx4=;
 b=c3zc1IRCy7VQ7BU8x0S/q0/UDglB5KkM2WiOJ9qedfl4ge7YuEuGunmCmnUW2CuIK5Cm
 XcIrA7jzVIJwMRvr7lfouFpkGO741d344G1FHByAERYZjYbFpbsL61peuhw/Ub9Yx012W
 JMsIta4UdSpPjzRDlViN0Pbcks8WnJgCw+zRKmWvj5qvtjGZ8Hjmr/pVcapVexGh2T6wL
 o+bcaw5+oCgaWhUrxpUweXIKr1tWjeFKG9C74y+iE43Q+zp7tZy4Myo/gjyre0YwZcxBP
 4ZAqyjA9uK1CZeBW6Y6fqnoCtFYTNgkxZ2uTuoPzM7/NK3L1PFQxG3x8I1FX7L5DmbQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=A5V876D6; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=A5V876D6
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C736640CC5
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 00:35:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C87943AB1;
 Sat,  3 Oct 2026 00:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C931F000FF;
 Sat,  3 Oct 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790987725;
 bh=t1p0oLFypoP2g6fx+M2RN69rNBfCYn1u5uYri41dGx4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=A5V876D63wqeWUoxkG6PB0i2QZB4ScqtdM3UC7jPUMvXct+srW/I+K3rMXbF1WyoV
 CYuBkN7faVfry1rAHZOvWjpc/gk9U1SFZ220bL3VQB+pEEn94pKmSustsw0dM26iIx
 e5M5HO5U/GhJ4mkpxOEb78eG/sgpHZzmgw3i2+kfXJpLyyibZ1z9TuOyaqql6UhI+X
 rAB3dkSxrOqaVZuLymj4rSDc1ZblDw4G3j/2kPPhHR44TxjMg1IawZ9XHxHH0Rskm3
 6bo3zJGrwbFOmAUfIDa1frtQ3bZ3ScL3K4GYlkUCXjm7MNagBBlBQUUmZ9hGBbtcu2
 uMP3+yGa7fF0Q==
From: Yixun Lan <dlan@kernel.org>
Date: Sat, 03 Oct 2026 00:34:40 +0000
Subject: [PATCH v3 2/4] riscv: dts: spacemit: k3: add binman node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-00-basic-spacemit-k3-v3-2-dea68cd1bd7d@kernel.org>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
In-Reply-To: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=649; i=dlan@kernel.org;
 h=from:subject:message-id; bh=P5NGQ7wXUfT3lOkRzloDiA7JM82JrlHJg7CJ4nYKOOQ=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqwE29V55aCqgktImYk6hrvjCZSxDZiIywF1jza
 l6mvVz2nsCJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCasBNvRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+13ZhAAizVQ61uMLaWge9inU9AbUo1vsFD9VcsF5RVTl0vCApujD33Mu5b3F
 xPeY/EAlgb76+Fr6cIvNZ6FxNha3V2MBrbiZ3UPWgHnJg77apUNSRtM5OolrI7bRb2FtF1sbanf
 wJoY8+ifrwePkqeUMIRgnGo5KsGYDlfqomcrObSX/bDu7fBaDfKdEQa2N+ahhWEHttO/dhvWrzG
 DI2O7WQTF5kOa+hiKSaRpyiYNzPLs1eo0cYj2B4fbNMyOLwfeTPKP7CHqBx1ujwKshwuNM2lDl7
 J9iioLhJUbJ4vTKGHYFqxUOO6LJovaz86NbdTYHLdiiIjNXlhhBVs1I1sueTa7lxq7R4+qvJmWg
 /K9HX1tz1w+RsqI3OeZu+Zz8XnC4wUTb75BxEG/AlyYKW4zwVVAtyO16CZ8bDZrTeKjkyAEn+O8
 XlkFnusGW9eDyVyw/0uOT5DwCBR9Iv+BrrB8ZgtohS8Ihltoobfv5eWdevD0nWEhxgWvT2MsdVw
 2Kv0ZoWPyitZ4m+B/u84sP8Duzt38yP6Jp1KsIaMLqXZfot4H1LaII8n0xsFyfyFDdd9i4VYde6
 /8BGBG7Hty+3YL0lS0itlK6M2Ja5QcLmdJ4SuraCwSeCBX/15GuMCH5Yuhj93i4rv6+leevKFbD
 953SydtLcFX+ymr1x2yKPUQ90RDfrU=
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

SpacemiT K3 follow the standard riscv binman layout, which has opensbi
and U-Boot proper, so include the common binman dtsi file.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 arch/riscv/dts/spacemit-k3-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
new file mode 100644
index 00000000000..f1c1c3ee6fd
--- /dev/null
+++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
+ */
+
+#include "binman.dtsi"

-- 
2.56.0

