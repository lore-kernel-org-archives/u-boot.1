Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B392C5DF88
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 13:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70B8080CB1;
	Thu, 20 Aug 2026 13:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6BoYMUxDkjev; Thu, 20 Aug 2026 13:07:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787231228;
	bh=MnYlrm4PiTYphr70LNM2zHlnUZdYUQKEJNjn4q2PrnU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mvKrYR0nRKaI5xgXk7CIYMqAlyHHl5kHvI6K6hRPFTXY5RQ66Jn0GsxOFXivXrA+D
	 v7rJSV07jeklZH3EscdBkmJ/44GuGveBNd20yb0wNkahWklLJdi/4lGPGK5LslRkuL
	 545K0DQvvAmP1QNa9/SIb1rxk09l8/MlJwbb3zWm3W0yN4VmpRo76b0o4V3NY2nTdh
	 T32ShT1sOVNr5XHaWkaBR9TiXd6SUpwqDrS1z73FVKW//4+JfYQJPVcDtnRNqKoEl1
	 rYZliX1tvEVd1FoT2TUq/7VXJImNu7M0Etr0VZjWibiTn2VAElHMYxpfv3h+Di4WV7
	 7rKlqJJhCpegg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EB5380CC4;
	Thu, 20 Aug 2026 13:07:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 75EA240B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C09E405B6
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 91V8k5NNJ6mv for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 13:01:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SDbLC/v5
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B765405AB
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:01:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C115E42E0A;
 Thu, 20 Aug 2026 13:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA10D1F000E9;
 Thu, 20 Aug 2026 13:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787230917;
 bh=MnYlrm4PiTYphr70LNM2zHlnUZdYUQKEJNjn4q2PrnU=;
 h=From:Subject:Date:To:Cc;
 b=SDbLC/v5CGGKKZ+q3/DAJx7VhNWPbDJzmMxl7zbLEEUo36qMUgf0xClU0Mg1oNt0F
 Fvdx+RtUkOiOIYUsnA0hIaTqr7l5mADPlqbGWPgxk641bCCQRpGMtZFo928ySn82MT
 RQgmG0QNH2YIXBrDZzEMpJd5wNBnRZ54f5NXPWzjs95zNFVsI6YXMTtqAJvjU63ibq
 FB40it8n8oyfQQ0E/t03f1vYjFenH7r8pqMbAxBOcuAyBB4y6fGgD64mm394unGIgA
 jeRS/X3WCtSYDdE76W4nJugOSwxuHlfqniGQVUpmUSKjNRfXPC3pYrgUINVcvJgUVH
 l5yrmnsMBPeOA==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH 0/2] riscv: spacemit: add pinctrl support for K3 SoC
Date: Thu, 20 Aug 2026 13:01:37 +0000
Message-Id: <20260820-01-k3-pinctrl-support-v1-0-b54a2450c895@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALH6hmoC/yXMwQrCMAyA4VcZORtIO1nVV5EdZs00Kl1JOhHG3
 t3qjt/h/xcwVmGDU7OA8ltMplThdg3E+5BujHKtBk++o4MnJIfPFrOkWPSFNuc8acEQmMd4JMf
 7ALXNyqN8/t9zv9nmy4Nj+c1gXb8CJjJieQAAAA==
X-Change-ID: 20260820-01-k3-pinctrl-support-77eefc901e47
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=dlan@kernel.org;
 h=from:subject:message-id; bh=9ejHwplj6PZ/WBx5cFBltiUkdD3OCenybGFZnuRWjb0=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqhvq6ZNiw8jc1c4hAeXu++jprGNVeJn/IXyA/T
 jS/71ntMvWJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaob6uhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2ENg/+OST7bRnRuHUQUeD0dXgV8hYnsDepvRle2vPy+W2jyxoMivOETVVXJ
 i8sxWMnHtIv3PgrdbFX6yWPrLxp6pD/7By+dzVJ8h02sDdGwhAUpE7y2lmTBRiYynd/+lwbVp1I
 XNcWoQ00x4s/UmM1e64X/ZVaXOlRzFHTdw6kWkGZ13DUnFmXou+6dlkFk3q0q51lEZ92Vu7SIra
 II9XbFnQxigyVYhKW4S/JdjD2nmbH/gHlOkShRE6PFUSqm0AgFC/PQQgQE9JfMVxZzMgIGs6IWd
 sAmwvH4hZ/sfQsRyErT+MKF8ssWhtJE3bjYOsBmJSzalxKvdUc/XHkXBq1e6S1063GjLMejjMZW
 Qx5GjpMZcqdbpbKZtF6/qRdLvwh7GL8jxf9HL8SYYyukpK7Msi0dnI/5n9ilDALeau8CK4472WQ
 4+nu2aNDpNRO08Tj3+349FBY/Y0Vp9WYX5kF6ypMETpicQjljIcloNWp9mqS1/ojxswcsogCzto
 Ka8+umyzHcgUAEs63MM+OdyzHXigNf45F1j5lEwBTYTY7E5jhAk8neNVSVq1n28xhh8TqZ0wXEU
 VU7NnynQl2mND2wZ7RrBZaZI2jQ1pn+u/mZVk/9pU/vNHROh734W9h5MCQdaAhx22AC8ahxqgS+
 mtAGe3n3yiq5765Gh0YOgdfaNgpMRM=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-Mailman-Approved-At: Thu, 20 Aug 2026 13:07:05 +0000
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

The pinctrl controller of SpacemiT K3 SoC changed its register BIT
layout definition comparing to old K1 SoC, has different IO
power-domain tables, and extend drive strength bits to 4.

First patch fix drive strength configuration for external-voltage
IO pins.

Please note, this series is composed on top of K1 pinctrl patch-2,3,4
which sent to mailing list here [1]

Link: https://patch.msgid.link/20260802-m4-v8-2-e916643205f3@riscstar.com [1]
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Yixun Lan (2):
      pinctrl: spacemit: configure drive strength based on power source
      pinctrl: spacemit: k3: add K3 pin support

 drivers/pinctrl/spacemit/Kconfig      |   4 +-
 drivers/pinctrl/spacemit/pinctrl-k1.c | 457 +++++++++++++++++++++++++++++-----
 2 files changed, 390 insertions(+), 71 deletions(-)
---
base-commit: 289cb83053b5939debd96508fb8a839025fab9ee
change-id: 20260820-01-k3-pinctrl-support-77eefc901e47

Best regards,
--  
Yixun Lan <dlan@kernel.org>

