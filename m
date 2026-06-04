Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8C5CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BFD18495C;
	Thu,  4 Jun 2026 14:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b1gpCWCs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8130A848A1; Thu,  4 Jun 2026 13:25:59 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA768486D
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 13:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EECF060236;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0207C2BCB9;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780572355;
 bh=d3GvolFPSaQfoz88JJUjH3k5JR6Ppas2xhoqjGmCHIk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=b1gpCWCsbUUaAArCJEOqFD2InjdH0YSG0lsoSc8XOKl/92M/o2IS+yJ2Hf0nNDZhw
 Ltasyqvw9Ogji01nKj3ecCYiDtI6KejL3xJIEc8QSrc2V3ND5s7GWs7dLeF+zaXHx3
 GXPTjCb5xd0SxOQGLhCEszY/s4aUtdRdSTVWSJ8EAHu+uTRtKWvtqlmTDwy27TGnue
 rZz7Oa1ZF8JqXZvESZ9fuSx1kREdRR3KybTR3rNXzyie8CsE76aE2FlLBABpkHGGjA
 pe9EbRcPovzipCB6ijLDvLdQPZ8s+stgRtRcfkrvQP4LGMl1DJaH4L8j78+ls/tM0Y
 TS9s+TvWksvug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 98171CD6E75;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Thu, 04 Jun 2026 14:25:51 +0300
Subject: [PATCH PATCHSET 3/6] ufs: Expose selected UFS functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-ufs_tool-v1-3-741ed00232c0@mobileye.com>
References: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
In-Reply-To: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Michal Simek <michal.simek@amd.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Jared McArthur <j-mcarthur@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3668;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=jLG9INhIC5pmpd09gKsMMN0n03KX2D3raG9S/PZ8P5g=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqIWC/HPg76TaE8H3+oDiwD6wb/trSxMR2RssYd
 ajUOJwh09GJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiFgvwAKCRCfmumUluiO
 OUVvD/9/cR2ckrSVySCnqqWnlUqsTYtJvCnZxza3VaDK9guQZJNGP3jxkbNEcUSMhq6nlFxtYY6
 u1lbgkvjKZl45ofLCcL+yygxYCwdb9MPf8geXVuv2AK+h1cvmwZFCaL9nyL9ANHpbTtv8+N7/gJ
 9sz1WP+NHl0r7N//pmPyFlZL5jNvzU+oaagXhMoxLhvAURSbKC5AK6nkxirN9g387DfhEsuSUWI
 gcbFm74Keq3QchmXGdGzUPwfF3l+UG1ky2FH/XpN4wQoMbn2rlvz85qXZ2mv0ouD1N2uRT0xejX
 uZE4juc2LW4aXP3lOrRI+jXTriWLOiW8Dpy+bCtOcg76EgKS05Bpr59l/wg6M7+hIHXNukusagR
 7cCBONyOZXKAuyV0sa6OfJgNQkcsofCQW0t2RNhR1+tmFZPoG8AM5JAEhH7jZl+zMOw4/UTSjI6
 yAPuxzJGLu/iaR7dVQJ1Q6z4yE1eVROlltk80jaSiQTo66H5i0Tvl2+YN98orW+sj8vo02WqGyL
 P8Gf2lfAFHkXupt4yGubQ9miwFwJFM90ozhefG5fTSniuaNL5WNdhBCN58iv3LjcHi13ajTIDIN
 NqATb6uB0Nk8HCT1Zr1q5NSjTwv+1vjtPPuc1Y4VMMx13BjivbmjUcmZ81a2TX8SUSxBe445Uaf
 fDJKS1YpKf8PsyQ==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: raz.benyehuda@mobileye.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>

Remove the static qualifier from selected functions to allow
future reuse.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 drivers/ufs/ufs-uclass.c | 18 +++++++++---------
 drivers/ufs/ufs.h        | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6a51f337e47..78f6064ddea 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -757,7 +757,7 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
  *
  * Flush cache in aligned address..address+size range.
  */
-static void ufshcd_cache_flush(void *addr, unsigned long size)
+void ufshcd_cache_flush(void *addr, unsigned long size)
 {
 	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
 	uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
@@ -1089,8 +1089,8 @@ static inline void ufshcd_init_query(struct ufs_hba *hba,
 /**
  * ufshcd_query_flag() - API function for sending flag query requests
  */
-static int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
-			     enum flag_idn idn, bool *flag_res)
+int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
+		      enum flag_idn idn, bool *flag_res)
 {
 	struct ufs_query_req *request = NULL;
 	struct ufs_query_res *response = NULL;
@@ -1320,9 +1320,9 @@ out:
 /**
  * ufshcd_query_descriptor_retry - API function for sending descriptor requests
  */
-static int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
-					 enum desc_idn idn, u8 index, u8 selector,
-					 u8 *desc_buf, int *buf_len)
+int  ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
+				   enum desc_idn idn, u8 index, u8 selector,
+				   u8 *desc_buf, int *buf_len)
 {
 	int err;
 	int retries;
@@ -1457,9 +1457,9 @@ static int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_
  * ufshcd_read_desc_param - read the specified descriptor parameter
  *
  */
-static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
-				  int desc_index, u8 param_offset,
-				  u8 *param_read_buf, u8 param_size)
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset,
+			   u8 *param_read_buf, u8 param_size)
 {
 	int ret;
 	u8 *desc_buf;
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0f6c93fbce7..75b7ff83155 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -218,6 +218,9 @@ enum flag_idn {
 	QUERY_FLAG_IDN_BUSY_RTC				= 0x09,
 	QUERY_FLAG_IDN_RESERVED3			= 0x0A,
 	QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE	= 0x0B,
+	QUERY_FLAG_IDN_F_WRITE_BOOSTER_EN               = 0x0E,
+	QUERY_FLAG_IDN_F_WB_BUF_FLUSH_EN                = 0x0F,
+	QUERY_FLAG_IDN_F_WB_BUF_FLUSH_HIBERN8           = 0x10
 };
 
 /* Attribute idn for Query requests */
@@ -809,4 +812,17 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 
 int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
 
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset, u8 *param_read_buf,
+			   u8 param_size);
+
+void ufshcd_cache_flush(void *addr, unsigned long size);
+
+int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
+		      enum flag_idn idn, bool *flag_res);
+
+int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
+				  enum desc_idn idn, u8 index, u8 selector,
+				  u8 *desc_buf, int *buf_len);
+
 #endif

-- 
2.43.0


