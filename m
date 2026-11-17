Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA618606A329
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VcA0qI99;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4h+mgT4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2380560841;
	Tue, 17 Nov 2026 02:53:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RHI0TtsyhSfS; Tue, 17 Nov 2026 02:53:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 03C6F60774
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794884030;
	b=CE+FpFFY9nBqROeQintrOJ38nZer+mbO5MjNHuLUV7xNwMrkdSYlFfI+ARRB0etduwrf
	 5GeRYdtUkwF/N0cy9RUaozfnyimOW6/Hi23Y8C8QUtu7Zrg/ioXRLdVGuiNU5BHt0cMlZ
	 ZEG+QCYfwphTODP4SwBLQYnvMceMOlgvJXhgG0Zy6UeOPXZO/AeKsrSRgzl9vFiwIj2G4
	 2MdRq6wW5fHSR8LU5/2SKOEzcspHDvECFJ7Ua873rjNJb39fhQbq12O6TmYeh7DgmrkCE
	 eTJ+0rAThsB4Prz26tcY0mxwz6kwS76NB1Etn7pf53nPa3kGln5hq5y54jf5xziXmXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794884030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QS+vQkk4YE/vqcT4ha2rAsbFFMZaeol0p2gjQGg7P+M=;
	b=qYJtv04TErP3E/Ets/2+FFpEAlPmvNOtCwUPINw+tl86m6Q8Ccm6QCoeTLNjwtQvZedd
	 FmE7mcaCtOMEhUs1CWaR2X+oL3wfgY8xlTd4eYJE+3kgudA3zczXfwQIVYbGdOAJJE4lH
	 ncLQgvXiOBbN+e/U+7nfEzbYDmtz3JyOmJVr8Y4ES38CXutCeALzi05tbMiJC+QFABFpa
	 a02thIqfOr1X4sCsDWdvXqI2YK+vOIm878YJvavXwEA/Ayf57ToQTDAUdTKcqltxN+Uh+
	 aLSvzZOSSHNugypG87Y/mIYAFURg1qvxMT8lfMcfo+STqu4JHaoG1tzAgO5bcMujz0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4h+mgT4;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794884030;
	bh=QS+vQkk4YE/vqcT4ha2rAsbFFMZaeol0p2gjQGg7P+M=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VcA0qI99ofjCiRd2MmqzIU5qq2XJt5nzoLOoMIx+8kzu3zgYCEQeQUkZx1bm9wqUZ
	 fr5SWLEKmbwjx5zXvYzQqQ/40FPxFP8idAMIVTLmxoVy2BEhwQyOwD/fOK9hecs7e2
	 TeMh95bP8jJSrXR2bk0+82KPEvumvmmw1pYPsfAr/HOV6aqT8n54lzQTNiwXbSog32
	 XWCOGdUKAGCJky85N9iiVcNwYI31CIN1BDDMWvdKfh1QSzZj3uZF7hEJKZ8wGMy2eb
	 dv4CkPW49OxNspY0g5BRP9OCtpnehVVNKHVlVSIyw2432QuWb+EwjO86ZJW/KlLuEQ
	 YGMjAN5/v6zqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03C6F60774;
	Tue, 17 Nov 2026 02:53:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A8F8613C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 02:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 920F560774
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 02:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sUxMi31IJbOw for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 02:53:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F638605F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=e4h+mgT4
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F638605F5
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 02:53:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7FFE943944;
 Tue, 17 Nov 2026 02:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03121F000CB;
 Tue, 17 Nov 2026 02:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794884026;
 bh=QS+vQkk4YE/vqcT4ha2rAsbFFMZaeol0p2gjQGg7P+M=;
 h=From:Date:Subject:To:Cc;
 b=e4h+mgT4MnHZ0sDko36oyCmlQSY0OB6TFZf27Oe6ejT7wZf84PmvcQ7mThkenN907
 MlJaN8KpT2uavEtrGddNSiY9Xa0eAQpyWLo1+wzjgBm7Yw6D12ClaKEqs9I04FMJFj
 FRT3BMHNN/i752DUvM29KdVMEVmUa/FVC+uzGm/lGKXFgsXXen+KYs2R/QchXKwDjH
 S72L6N7hdWWdF+s+OP1+t+IugClkW80omVnlA5dq/m9/cyjlq32dFyCxxkwcY5Fumf
 DpyjijPrbeKg5rZA1d83zt5AxvE1x8g2aQuaHRNKdEqFZdbLxgi0heORu5ESmNzjaI
 ESl7QPyKdRG7w==
From: Yixun Lan <dlan@kernel.org>
Date: Tue, 17 Nov 2026 02:53:39 +0000
Subject: [PATCH v3] board: spacemit: k1: Add the M1 Jupiter's product name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-04-k1-milkv-m1-prefix-v3-1-18e3bcdda11f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6CMBCFr0Jm7Zi2YAmuvIdhAWWEESimxUZDu
 LsFDuDbfS/vZwFPjsnDNVnAUWDPk42QnhIwXWVbQm4igxJKyygUGfYSRx76gKPEl6MHfzDXKhe
 ZTnNTVxC7h73v3suD/bt+kpm3sS3RsZ8n992Pg9py/z6CQolpU5EwhZSFvtx6cpaG8+RaKNd1/
 QG7djRPzQAAAA==
X-Change-ID: 20261111-04-k1-milkv-m1-prefix-762704637cba
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io
Cc: Bruno Banelli <bbanelli@gmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>, 
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Dave Klotz <DaveWK225@protonmail.com>, 
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2084; i=dlan@kernel.org;
 h=from:subject:message-id; bh=ATNpDlsC9tUMAA/XBsALfC7GIVm3HgrFGtVcvHH8g44=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq+8G1kIY0cX8W3t+qFPOhrXrlETWxsoyGWMywg
 iXEo/5BENyJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCavvBtRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1ilhAAkoo6XmTfCYRrPUUy1N/peGCzyLKatKwnS6M1HGhaCgXRTjx87hQCc
 tqNwDCjH5sDUlhXXxZrn29Zx72/ww5rAWj9jXUONq+8cuJVwugm3cvPLrPvPgUu4g+VsFnTQa4N
 RrgorV0fkgAoeVw9ORZBMTnDqnJNbIo8Ruo09AOfKh880Bp8djmzcw7nwUN/1y1zsgmv6wqGah9
 tzuKy01B2YaXJXU3up4vyvtx8/xMm7uiD0cUi1XMK4TbPD0F63T7BVjNFSn54Cm5nFNvrWCHYmc
 awutq4B8GcG7Bf2jp6rNV8VWD7reQMzxVc7QWro29lzqVILSdUMhU2IB2sf/Jt2KhCzi/01sBKe
 4UfWIDdto270dsb+VR6e78u1JkwVWxM2GBUecXU0bDAykzayTekNEPHziJyEhwrJDmnO10uwrPx
 AaFFp2Zw4yiFVNCM1+YmG3/lJyXEcmBitd07EGQlBBv0NkIRv0P09SdZSiMn+kRNYHu/MTPz4VA
 HRY9CzB7TRW08w6OtaJgE1PU3460LHf7/LhJejg8Ev6OPCwKLTwLAHBiuj6wrs9Z5mTTf91iiLu
 FhCA0e9KMNzTnSQMLwRfVZAShUupJhO369JjXIHmVfRvkltxFTwN5RZnDnrmkKRsyr/NLp770r3
 WXFSVkDRLbm6uJm/jRag1GTP/QrCyE=
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bruno Banelli <bbanelli@gmail.com>

With K1 board map, it will derive the device tree name from the TLV
product name held in the board EEPROM, and problem here is that it
only recognises boards whose product name starts with "k1-x_".

Boards fitted with the higher-binned M1 part report an "m1-x_" prefix
instead. On those, fdt_name is left empty and the function silently
falls back to default device tree which defined in the config option
of CONFIG_DEFAULT_DEVICE_TREE ("k1-musepi-pro"), so an M1 board selects
the wrong device tree with no error or warning.

A Milk-V Jupiter fitted with an M1 reads, from the 24c04 at i2c2 0x50:

  00: 54 6c 76 49 6e 66 6f 00 01 00 1a 21 12 6d 31 2d  TlvInfo....!.m1-
  10: 78 5f 6d 69 6c 6b 76 2d 6a 75 70 69 74 65 72 fe  x_milkv-jupiter.

i.e. TLV code 0x21 (product name), length 0x12, "m1-x_milkv-jupiter".

Add an entry to map the M1 Milv-V jupiter board to correct device tree.

Signed-off-by: Bruno Banelli <bbanelli@gmail.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
I've dropped all Reviewed-by tags due to the change.
---
Changes in v3:
- update commit message 
- Link to v2: https://patch.msgid.link/20261111-04-k1-milkv-m1-prefix-v2-1-3dae0c911965@kernel.org

Changes in v2:
- rework according to recent main code
- Link to v1: https://patch.msgid.link/20260825065257.69536-1-bbanelli@gmail.com
---
 board/spacemit/k1/spl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 0ce0a811830..8931c5f5362 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -149,6 +149,7 @@ static const struct {
 	{ "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
 	{ "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
 	{ "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
+	{ "m1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
 };
 
 int read_product_name(char *name, int size)

---
base-commit: 8ea02c99391d2d922810065206721ead2863f075
change-id: 20261111-04-k1-milkv-m1-prefix-762704637cba

Best regards,
--  
Yixun Lan <dlan@kernel.org>

