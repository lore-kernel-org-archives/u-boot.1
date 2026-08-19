Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3DDC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 13:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 261204060B;
	Wed, 19 Aug 2026 13:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t9R4RWaTXXzS; Wed, 19 Aug 2026 13:04:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787144640;
	bh=qekmoumrVDtnTPacR5xE6Sz4jCplwUb6/7iijp4Gibk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lVwPAz2XlO/sa7HCn7mvkNUTR2zfhmgWZm/ZO+zrSewJsSDyAmZV18lZGlaDKqOZQ
	 zqGfQukQQavZga/LBCj3qF2zLKwzP5x4LxflEUi/7RnhHjS+O3+3ubMv8XFlYzFvSg
	 RdWwfPESH1g4HrDOze81/qro/MnZxmxcfF8DLzooPvyjObCtLLENqGp/6b/SURQERU
	 m6ZhpW+9eWZwyV30qPX5xYKtdb95VnivMJBlk9NGjXGXYwdCjlKsV4lfDbhpL+zpZX
	 o1Wx86RIzWl6NSFBtajhm+3ZKYvbTxbNYaAf9iWocfFy9YcqO3Yg1uuaZXpZIAIRKq
	 d8nB0iNOTmipg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4298B405CE;
	Wed, 19 Aug 2026 13:04:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CE672FD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31F6660681
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:03:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Ofsrp3e0qhs for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 13:03:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::42ad; helo=smtp-42ad.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=BHUeiFne
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::42ad])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 991CF6062C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:03:55 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hQ6Fz6zSYzf5b;
 Wed, 19 Aug 2026 15:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787144631;
 bh=qekmoumrVDtnTPacR5xE6Sz4jCplwUb6/7iijp4Gibk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BHUeiFneFFMWPWOGAY9xiMipBN+JQawQzbgVvCR/t7dBQayISKmSCPFMPNCAo/aQv
 xCY3fA30pNi/ia4+cqHz7G987PqUZI/+k7tWfFkWnDEgLAHHSPzp+xTzH9LPOPNrrm
 jYBEBN17jdBE3rbj1/zYAKve9Y4es1KqsDCWJmTykMgRc9AM8vtztAfGCFp4PDiz5W
 Ls/StsRD2ZhwwplT+TQbQrt4jTAg+LswK507p/g08zVYSmtN6NrryRHm8yHyYo3H1z
 PQO7VqDikkJBYbE/MDJTMW6EbjhvPUMg+pMvdUwxnUhqdNDBLWIOBrfDDRufEt2Bf+
 Ss2LGY0wZLA+Q==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hQ6Fy5GDczRvr; Wed, 19 Aug 2026 15:03:50 +0200 (CEST)
Message-ID: <01e9bbb5-508a-4582-a144-fdf14370a0ba@0leil.net>
Date: Wed, 19 Aug 2026 15:03:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] rockchip: doc: add notes section
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
 <62f1285d-bd2e-48e5-be61-a7bc32d1a1e3@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <62f1285d-bd2e-48e5-be61-a7bc32d1a1e3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Johan,

On 8/15/26 3:08 PM, Johan Jonker wrote:
> Add a notes section for things that don't need
> a chapter. Include some rk3036/rk3066 cases.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   doc/board/rockchip/rockchip.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index d5945e805ba8..6dbff5b72d90 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -325,6 +325,14 @@ To build rk3588 boards:
>           make evb-rk3588_defconfig
>           make CROSS_COMPILE=aarch64-linux-gnu-
>   
> +Notes
> +^^^^^
> +
> +* rk3036: SDMMC and the debug uart share the same iomux, so if
> +  a SD card is the boot medium, the debug uart must be disabled.
> +* rk3066: eMMC and NAND share the same iomux, so if in Mask ROM mode
> +  and a NAND is the boot medium, clear the emmc_flash_sel bit in GRF_SOC_CON0.
> +

Use .. note:: admonitions (c.f. 
https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-note) 
instead, so we don't have an additional section.

Something like:

"""
diff --git a/doc/board/rockchip/rockchip.rst 
b/doc/board/rockchip/rockchip.rst
index 6dbff5b72d90..b7705b1df6f3 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -325,13 +325,13 @@ To build rk3588 boards:
          make evb-rk3588_defconfig
          make CROSS_COMPILE=aarch64-linux-gnu-

-Notes
-^^^^^
+.. note::
+   On RK3036, the SDMMC and the debug uart share the same iomux, so if
+   a SD card is the boot medium, the debug uart must be disabled.

-* rk3036: SDMMC and the debug uart share the same iomux, so if
-  a SD card is the boot medium, the debug uart must be disabled.
-* rk3066: eMMC and NAND share the same iomux, so if in Mask ROM mode
-  and a NAND is the boot medium, clear the emmc_flash_sel bit in 
GRF_SOC_CON0.
+.. note::
+   On RK3066, the eMMC and NAND share the same iomux, so if in Mask ROM 
mode
+   and a NAND is the boot medium, clear the emmc_flash_sel bit in 
GRF_SOC_CON0.

  Mask ROM mode
  -------------
"""

(I didn't reword Mask ROM but please take into account Jonas's feedback 
on the v6).

Where did you get the info for RK3066, it's not in the current 
doc/README.rockchip. If it's something new, then keep it in a separate 
patch like you've done here and add some more info in the commit log. If 
it's something that already exists and I missed it, please tell me and 
also squash with the patch that removes the text from other files if 
applicable.

For the rk3036 part, please squash with patch 4.

Thanks!
Quentin
