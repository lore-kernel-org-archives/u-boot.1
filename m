Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89524CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 05:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ACA780ED5;
	Wed,  7 Oct 2026 05:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W5LwCRu7R7hI; Wed,  7 Oct 2026 05:41:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8866380ED6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791351673;
	b=k5rYWUcAKsf8MG79vNkhbR7pjHgUapxCwWiyO/HWW7W1Bb/QIo0UOrLujlNhTwAPRZOp
	 Ymwtt25TkdaRLCYRaeNsRwaSXe0k7ggnucwIx69alnyeRaTWOIWweieiqMaMXnKAdK2RE
	 Vtb6IS03sVFOc2SoHZhMdgUlzaxjc1vxPIJy0/GbfQwAPzFKMsSGzTczLQnr5kVr9CvOy
	 Gt15IakGZf1hp75VZU2i9DgGgm4bjempu+sQDTIgiSrAIvunhBCtU7rnuPkp10P4E8WB3
	 5gb+7y0Syd+/R5nwLBweTUmALuwZH1kCqSgxRqnby98HK8SJ8HcPephbNQArR7KFUvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791351673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hSAcZ26+rB9PTWjOhSV0GyzlIgmhhwUt3Lo3Ndpynsw=;
	b=TS4FRJRVfEu74gSQGCm+O3LcHCFsL29HRdNXHQEqR4Hxe7UvFzD4FA6AZ6OCjPDQInPO
	 kA4QkGWiTkQA8PF8sg8ZdUbbakZDsk5VkkqZG6Cz0jY0troCHwdy/PIEb0VsXcQXooLE5
	 /M8v2Sn51qZgHLwoNEoE20ZVC3kmATBCBMrsz75AcekOeHZ1WIGS6J+cJ8Y/ncHxzrnVM
	 zAwQh/BroHILo444sJxoGl4bXUJvxbtDopwPfzx+YPJi0Mu5FCKvT9ZPWKJChsNU5gJC6
	 2NG+wOIT6a8ws28BeCOgj/bQ1BzcXxPTrsPHEuyQ61fjPVja8gqEBjs/aeC79xNDMyQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDfMYvI1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791351673;
	bh=hSAcZ26+rB9PTWjOhSV0GyzlIgmhhwUt3Lo3Ndpynsw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nA5rpWGqpO34Mie1oR0U50vsLklpLpr3bnT3QNR9ttt1awLWl5yA1jBIX0UVYqb7u
	 TxWsjBMvJpJacWrFHCS4VDqwjC3/6wNesdG5Ho63AYjFvsZzzHqPMBK5OteBSNoHOy
	 BilsMVU74SeLoQSI6zaAPrAip5i6ImanJn7jiSmiErrENarXvo+YJL4mhCwDNR6r4s
	 1Ld8tO+8XDxsnWtDL0FLYhZS6bkI2tHjClLl9Mj3je3oZ39v0IAzJraLWC/Ed/KhTO
	 XaDK7BXQdxSBgeP7+vyNKCn6up7vLm6BK48bqOXEO+Zo5f/IyTf9ExtkqpInwSp2Wu
	 HqZTofsBTnVZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8866380ED6;
	Wed,  7 Oct 2026 05:41:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E308A08
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2FE5080EE4
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AKmnUR_yGxPT for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 05:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ECAC180EDF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791349921;
 b=jvjQPo/zPEltQuD3LiVw5M1css8X8n9HCMRQyT82ClyDg66gbinx+gucBLHs4TUDfpes
 O9W5OPxMOrBCHNTUsbZzL9dKz2lxWEZNvlZS5M/1aBAEYe1cNb11iQU+gh50Lnb/432Re
 wRgSvlRcNqpKdsmadhMu7YoGlg1VfecdKgUOCK3x3KGqxh7xAoGzQAjYFETDLEVx50K7/
 OimdOuHX1DmDBq+xHKYliZXAGqUGAavqP/KK0BFMI97GMMJbu4pzItNB4HXOPPWwMldOw
 SF4AvdFy5WOdoOMPIp3/SHkeuek8D0aacc/AFcok/GbCbraJBpWTUXl+5eBwfWPppag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791349921;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=hSAcZ26+rB9PTWjOhSV0GyzlIgmhhwUt3Lo3Ndpynsw=;
 b=bv/Z/J8ylVoDLm0jqRSw59UCi9/QwbNU+fjCH64P0Teeyxbprz0FBJGXDSPD3Jgidj5z
 2CKOpAG2wvFLsB1Fff2zsXRiD37F80RN2oVuBh6POxqlqIOod24sjnOCo1QklRDQFs5sR
 e90oC4bYSmXEfwyPy1sHHQwu2zr2WL5D7DmGjBpoVQ5bhvcIVVv1z9fd8Omx3Hq3V2g0v
 KUvqj94zhtGFamLQdG0rFXYOxI51ho9nF/CO6n3VK1RlN6GLm8yiE5+3SL2bhc1uPPMBr
 a7LlcDrkv8a/z1ckKO74BwYp/d1hqcfwiOIvV9F4zAnu00EnoImqDn06YpHqB4qJFXA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZDfMYvI1; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZDfMYvI1
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECAC180EDF
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 05:12:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 77978600C8;
 Wed,  7 Oct 2026 05:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FDD1F0089B;
 Wed,  7 Oct 2026 05:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791349918;
 bh=hSAcZ26+rB9PTWjOhSV0GyzlIgmhhwUt3Lo3Ndpynsw=;
 h=From:Subject:Date:To:Cc;
 b=ZDfMYvI1hO0HNhqWmLdHK06Z/m5EdPSZa3dp3QdEHjaibsVDgCanO8x0dhSsy2UDC
 X2oxcHnLfyDZRe2NlDcqGTRdFqAco31DxdKu8li0gXUj+5KZhWEZ3eEhUGmJd2K2Qe
 tH62Da+lM20IECNPDA/xdRRnuMBKHL6h3ydvDZ62ji72sxZKODHhjknkuMWD0Bmhhl
 6uO4ZRnrFuzZISa81I3I52RLztgXUKN/zCCGPzEDwrngDeBld84kBr/WvKOdTnnv9r
 qX5qU2hhhcBnVN0Bh1kErCZMYam+9leapHLQPMx+kT12+r6ldcW32dY2En0sm0ygHb
 ds/OMmtlCo08Q==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH v4 0/4] riscv: spacemit: Add support for K3 Pico-ITX board
Date: Wed, 07 Oct 2026 05:11:30 +0000
Message-Id: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOyw7CIBBFf8WwFsOAQuvK/zAuKEwVH20DlWia/
 rug0WjU5Z3cOecOJKB3GMhyMhCP0QXXNinMpxNidrrZInU2ZcIZl6zkQBmjlQ7O0NBpgyfX04O
 ghSgASjlfWFGS9Np5rN3ljl1vHjmcqz2aPrNyY+dC3/rr3Rsh954K8VsRk5rWGhgsam4sVKsD+
 gaPs9ZvSXZE/qIAY/wPhWeKlUqVmglQ5osi3in/tqQ7tahlkYdYZT8o4zjeAKilydFXAQAA
X-Change-ID: 20260921-00-basic-spacemit-k3-838119645d39
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243; i=dlan@kernel.org;
 h=from:subject:message-id; bh=qwdrz3gxC96SY6E2s+JBvZ3ycEeXQ+SpHgzyDDBq2RA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqxdSL7IJLU/sqTQmChDnFk1PLw4i78VoMxpS3Y
 YcFHgn43hOJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCasXUixsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3Vzg//djv73/UCziwMnVWiWIe/NukV6r1+MwZ+PrUPmRcNeBAHp4Oxb9BF2
 uzatCJW1u3RvVGqqGiWFTpgB8UEEpLiSJXDyB/6OMzAHIPVY13gyvcla7KZbYowf7InExweN78q
 Mum7drEvVk0beIwEWomuNX9iBHAPVNypOePcX4nS7onGD7ccBRR/LBMSQ04L6VZT76ntYsdtIOJ
 cFd+67oyoy3yw7+Ew0jK2YdMWnJH191vSae/x4yy7SG4sqdVJ8RnRKoN2KvzBrsHsjquiKx510a
 0pSDK9IvVTQy9eEjXunTy+4aUo8SERddnDWc3C6dhv8AQL5Xei/+/3vr12JqU1ZQwG3YH5FXt5Y
 UdL2qIlDz2Unz8OTajDfv2Am09huxhd3ThoEG/6Unxlc446TF80YFWP2gxNF5bCfLsxjE6K3nrQ
 s3KL+t3KMTCQxmpXHk56jd9jT1pAYZIs05lXaTza9S0FdSVrfYbpYZRZeZNkcPK0WNiaPpbI5mQ
 eyScu2GGbV3bZcHwwDGWjcRYGP/Q56bNd4S6W4c+N+VrEDK//Uxew+WUBAjCg2f2/xXop+etw2F
 /+qFvVBsvyrrOGtvWk911cYrLKJR4Io3LR3TmV8eBUSbslH8jBfawVoVDW4zhdZ2Z9cVfpX7MVI
 gF5BQcMCiV52jNYGpdrW6hJ3hdOSZo=
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

Add initial support for SpacemiT K3 Pico-ITX board, the config file
will enable all basic components which make it able to run into U-Boot
serial console.

The series actually depend on previous sent patches, I'm not adding
dependency to this series, but list it here for reference.

Pinctrl:
 https://patch.msgid.link/20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org

GPIO:
 https://patch.msgid.link/20260822-01-gpio-pinctrl-support-v1-1-6be2f4c71c5d@kernel.org

clock and reset:
 https://patch.msgid.link/20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Changes in v4:
- update doc
- add separate binman.dtsi file
- Link to v3: https://patch.msgid.link/20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org

Changes in v3:
- rename header and dtsi file with vendor prefix
- Link to v2: https://patch.msgid.link/20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org

Changes in v2:
- drop board_get_usable_ram_top()
- drop empty source file
- Link to v1: https://patch.msgid.link/20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org

---
Yixun Lan (4):
      board: spacemit: add SpacemiT K3 Pico-ITX
      riscv: dts: spacemit: k3: add binman node
      configs: spacemit: Add K3 default configuration
      doc: spacemit: k3: Add Pico-ITX board

 arch/riscv/Kconfig                       |   5 +
 arch/riscv/cpu/k3/Kconfig                |  18 +++
 arch/riscv/cpu/k3/Makefile               |   5 +
 arch/riscv/cpu/k3/dram.c                 |  21 ++++
 arch/riscv/dts/spacemit-k3-binman.dtsi   |   6 +
 arch/riscv/dts/spacemit-k3-u-boot.dtsi   |   6 +
 board/spacemit/k3/Kconfig                |  30 +++++
 board/spacemit/k3/MAINTAINERS            |   8 ++
 configs/spacemit_k3_defconfig            |  51 ++++++++
 doc/board/spacemit/index.rst             |   1 +
 doc/board/spacemit/spacemit-pico-itx.rst | 200 +++++++++++++++++++++++++++++++
 include/configs/spacemit-k3.h            |  13 ++
 12 files changed, 364 insertions(+)
---
base-commit: cf615aafae36fc49f55e3e6a3648d29201b26d51
change-id: 20260921-00-basic-spacemit-k3-838119645d39

Best regards,
--  
Yixun Lan <dlan@kernel.org>

