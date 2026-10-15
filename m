Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B8FCC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 08:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE954810BF;
	Thu, 15 Oct 2026 08:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ceklIXxcR62q; Thu, 15 Oct 2026 08:27:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D34EF810C1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792052878;
	b=R+C8K0dQDRPME9bOGvyym2w4lkfsAlwWDYHjwQ9nPU5w/f4LORiidJWqHwCN6qNzwcX2
	 /TvaKs9wXmaSEVyDCzK8YP28irhLDtOBsx3XbKwqrpOJ0x6lQSZDQ8Ywz50PkhRkHTlQd
	 RrrPerKxl8iiQnBsZ3MlKiwvkmq9OyJ5RUcCa4k3v2A4EpbtjBop3/wyb18DGQKkZ+ZNB
	 toatzIym4bBJwS7mEbiXywTPzpxYyOVJyKny3a38KoJaBrptbkt2kbG1EgOkDedARPsKh
	 qHuDOeP1Oml+3vQG2L9Hb0OFZL99NFQyx8n0IGHl4nOtsS2R8VJ89mSz0B5OVoh5Ekw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792052878;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Virus-Scanned:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sohXiN1yhOSdhIv+s+oGgttYLUzLMKJO+Uw1ijY/vfI=;
	b=aK7BoPAGMbh48SstabEhK+eJ64+GZd1fZiX2oQ9AYvNBkK9YZabHriUljGRaAbomWyrp
	 hAQnPYQGc8AB6OmX6SUFwmfRz5+ElLuAt/xD6gOcCE1lKmiCDD1rHYW9QrM1rtUM7is5w
	 evrB+BlR1GhA/MInmb54diVneq7JkVsmJnqvFQHPiIFjgu9A7d17V8Cbf8ysNZxTk7xF+
	 4hKr8D8RkM+P26TTqdk9ZdrkASRqj57eB05farF9GqfyzRgIKC8wK09mCzc0a/bLTr78s
	 vxp935futn7qUE74v0HiNxy2xdk8phitGLM24v2s8V4oNdRFRImlJduqx7ciURMRXbA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.nxp.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792052878;
	bh=sohXiN1yhOSdhIv+s+oGgttYLUzLMKJO+Uw1ijY/vfI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nlqs6bSIetEXDiPwqZge89QQw+fnxPBaYxS4bBVew7nf1q12VgzEw2jmQedBjDAq7
	 STd8tSrte0C62BWFKBfNK1M2lw2FR0foPQ0uO4L3HSaPu5NUrp13hRe3vlNq/LEiw1
	 a51SKV127JnvbbG1s4SeS4y4pit6HqQLvwMXGVSavQy58P8xkJY9DhPJZmyIHne2bG
	 2jmQAZ0+bCLqb+hn/A0pHmkjZrGhgcIrh2z3ZJnM+2euOCacVL56XobnFSSY5OHXf9
	 agkkEsIcdrc4IXkuQsYUHPGdbPTz2eFrDkwFJeoSQvgbw9oL360/9i6o0+DFKKx/iE
	 /W0az205NE69A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D34EF810C1;
	Thu, 15 Oct 2026 08:27:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CF662E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E38381008
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:49:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pVCpw6XQwKKX for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 05:49:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2880481007
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792043351;
 b=BXKk6QO8uj2NIVuqcK6qicKuymU4dthh+lMbhNP7Gz5k3BfMZCHjccvVQ5ZWjn8YfIYS
 bcA+7zxyl5H8UYo1gIq+crvLLanSgK9JpeIoPzFfFPbodnGWnX08kxlf57Zb0yYjnb9pM
 cup3EwuhGo3XTbFu2dPqpBx4xs+xEfvZlqwmeQCovXP3oK/jYod9DvuSVMfp1S3B5nPcc
 kGgf4ZUp794iujqmaj6AEczLF1JInXfzG6Fefeoh8OrkURmJXzTT6D7DB5Fiw9NFtQdvk
 c6NDM6PnAOJ4xnKO/pCE0JeCRGMP4LkBxlEryMcr61UHRJOe/YKyVZsA60qbVxNa4ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792043351;
 h=X-Greylist:Received-SPF:Received:Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Virus-Scanned;
 bh=sohXiN1yhOSdhIv+s+oGgttYLUzLMKJO+Uw1ijY/vfI=;
 b=XiVEgyG9tgQb4GKmWBZvvl9IKaqxHmUXmY0mj9qCGx8+shDMTZoQexguLcpPaLM0kHtM
 MXmV6jzTYrD/XcsLT1KWUOx4tlN9gAgUGywRJLSuHmhC8Rj6uZQWkGlxfbHneRp8BSaZg
 v2bbSJkg7IUgmHIoQ7Kftd1ARCamQlNv1RKhNHdqGbcEF1mc7rZ5dNIMYZVNaCoFh8DTm
 EnGu5s67DeJKuM9Amxx8I2G1FhlcIRZvdFq1c0jPl9/Tn8cxIjxnisvGwf81gsr/uJF7w
 kwxZZKkbbnHAxiOl3PZpeKiO8+79bCB+9MJ6Vj+ShdfVhuG2sJ5TQ+EMnxmnQYEXerQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.nxp.com;
 arc=none smtp.remote-ip=92.121.34.21
X-Greylist: delayed 557 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 15 Oct 2026 05:49:11 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=92.121.34.21;
 helo=inva021.nxp.com; envelope-from=qijian.guo@oss.nxp.com;
 receiver=<UNKNOWN> 
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2880481007
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:49:10 +0000 (UTC)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBB43200133;
 Thu, 15 Oct 2026 07:39:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 87278200053;
 Thu, 15 Oct 2026 07:39:51 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 80DF91800068;
 Thu, 15 Oct 2026 13:39:49 +0800 (+08)
From: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
Subject: [PATCH 0/2] Add initial support for FRDM-IMX95-PRO
Date: Thu, 15 Oct 2026 14:39:47 +0900
Message-Id: <20261015-frdm-imx95-pro-v1-0-d354da03ca68@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNn0GoC/33MQQ6CMBCF4auYrh3TKYVQV97DsKB0KrOAktYQD
 OHuFhJduHD5v+R9q0gUmZK4nlYRaebEYcyB55Po+nZ8ELDLLZRUFUpU4KMbgIfFlDDFAIXRpbZ
 kTSkrkU9TJM/LAd6b3D2nZ4ivw59xXz9U8UvNCBJ8Zw3VVrVYtLdxmS5dGHb376n2SjupdSXRf
 U/Ntm1vi3nVxt8AAAA=
X-Change-ID: 20261012-frdm-imx95-pro-39454beb9506
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, Lei Xu <lei.xu@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792042789; l=1193;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=oGOWNHHxYp6afjYs5hUDltAaQijHGPDRNUWu/j6aRJg=;
 b=Jlsa3F55ZeZ8lw3bbOPr7q+25mtYpKSQwEkuC84otla2KH8mHoDBbNhlfp0zOCtHgyOtqva52
 A85272wINg+AwaVbs6Vf8ho95zYCKvOIisRm1zsGjFM7Dt4FaO/AM9/
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:27:54 +0000
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

NXP FRDM-IMX95-PRO is cost-effective with extensive
expansion capabilities based on the i.MX95 19x19 SoC.
It is designed for AI and robotic situation.

Difference with i.MX95 15x15 FRDM:
- Use i.MX95 19x19 package
- Support 2 KEY-M M.2 PCIE
- 10G ETH interface
- Secure Element interface

CI: https://github.com/u-boot/u-boot/pull/1055/checks

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
Joseph Guo (2):
      imx95_frdm: Kconfig: rename board prompt to imx95_15x15_frdm
      imx: Add FRDM-IMX95-PRO initial support

 arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi |  65 +++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |  10 +-
 board/nxp/imx95_frdm/Kconfig                  |   2 +-
 board/nxp/imx95_frdm/MAINTAINERS              |   1 +
 configs/imx95_19x19_frdm_pro_defconfig        | 153 ++++++++++++++++++++++++++
 doc/board/nxp/imx95_frdm.rst                  |  29 ++++-
 include/configs/imx95_frdm.h                  |   4 +
 7 files changed, 261 insertions(+), 3 deletions(-)
---
base-commit: 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363
change-id: 20261012-frdm-imx95-pro-39454beb9506

Best regards,
-- 
Joseph Guo <qijian.guo@nxp.com>

