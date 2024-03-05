Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4BFC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 07:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D72AE87FC9;
	Tue,  5 Mar 2024 08:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="rjqjXdjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC44987FC9; Tue,  5 Mar 2024 08:39:13 +0100 (CET)
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com
 [203.205.221.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C3287BA8
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 08:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1709624341; bh=/Kp9DA9Myi+jMRjV6kvBcXcHXnt0U234+7s5FQJqWd0=;
 h=From:To:Cc:Subject:Date;
 b=rjqjXdjnkco36Y9BUs/XVApH6h/zVKtRA47bHsmLhgg2XJmsijO572H9ZpjB8IpvT
 iy6Es9LYZ5O8BojT08WtyvaJ7U2wjYgkxG8mReoK7Jez2NcYiSRhmId04lsQVFm78l
 /QgRoUxMWbfotOYFHGLMEyFShwYmZ3xh6iE3WIcw=
Received: from localhost.localdomain ([183.172.219.254])
 by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
 id 9BB85255; Tue, 05 Mar 2024 15:38:59 +0800
X-QQ-mid: xmsmtpt1709624339ta13qwcnm
Message-ID: <tencent_2AE7952872F803E81AEF7D49589E6CCEFF0A@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMma8CaA269/WIGV3/ltVSGR8621dZANmvn/0WAihbUhi3N64Rtz3O
 4qDjUP8lwwkrrQVwp9PwFxTL4JX9HaDiwc27kgyW9obXotGQXS7v0t9uWJQWPYuLXbhO3H0vkOo+
 YhmFT8U4aKjf8sXQasG0bd7upc0PHDxFOYMthHCeGiTC/RwSdwuBtDV0wPQpiXC7tFUtMpaCsESJ
 wImO7pljx8McIIcUFsyVwxtGtsJX1VHgJtpI2R7wDOgH+th3uid0MjqiKs8Yzciyga3fsRzPAgUB
 sORFCvSyDUjgOc49JuqSqRkL3a7o/sSmNczXdvTNgyvPiBxUyuq/xGf7BxaLQ9r0rwcn3LASFNgX
 52MhZoRn3RC7JE33red/MXD/qPrHJo4LRoCl8VX9EMj3M+YfiG9Zv2lSQWV7xjKMj2tjZ8DXkZuv
 nFamkuli80xn5Kz2euvMhKd4rwYx0Us2JzCinBgorCKieyojmEoEa7Eu7JV52tNAVWNQB9eYWYbf
 NTm4LM103c6fx11zATxKnTFmaTvGkNM0YqJgh9pxdKkdMTjly79eCUwf2DtadFGORRHy+1LqZ/R+
 SkJuFYQmjy38egNyTfggDeYPV6qCsrvTvEEy1PAAS6GM9QUAa44F85bQHD/A8Y30kIy05PEDSAHJ
 hR/jQgK+oR4BA+XNX86yjaakNWha7qvo8gqzrWS3o4UEsuEDsqaT9JBS+OLsjxs2Eh4j+tm8kHaU
 mD8zt7rxucGAISp0TjTToC43vCkTxleJ1byxOESSMf3lkEanJlsrJQzExUAy0x9xUOfVxsvehVpx
 5/YlgDzF0LBMJPdSaMFy3cMDvf8o34Bh5LM82OjlKsjdTd0bvSCvMT/+s5gHm6i+UlubdASYnai6
 bxtvjZ08EF265dvQrfqdxkdpCeYdWnyvIN5YHR6DuTx2eqd9TtxH2AttHEpQnCohGSq/PYTT5eYm
 FZmbeQ/z7hPFxwEuJVM0ZtOMFlhE2XOo05Om4e2yP3OBDAnP2E9sMNbYWwfUAOQwiof5a4vu8=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Hanyuan Zhao <hanyuan-z@qq.com>
Subject: [PATCH v3 1/3] cli: panic when failed to allocate memory for the
 history buffer
Date: Tue,  5 Mar 2024 15:37:33 +0800
X-OQ-MSGID: <20240305073734.14483-1-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This commit simply modifies the history initialize function,
replacing the return value by panic with reasons. The calling
chains of hist_init don't have steps explicitly throwing or
dealing with the ENOMEM error, and once the init fails, the
whole system is died. Using panic here to provide error
information instead.

Signed-off-by: Hanyuan Zhao <hanyuan-z@qq.com>
---
This is v3 of patch series cli: allow users to disable history
if unused at all. Please ignore the v2 version.
---
Changes v1 -> v3:
  - Separate the first patch and let this patch be the panic one.
---
 common/cli_readline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 2507be2295..99e7efdfe5 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -110,7 +110,7 @@ static int hist_init(void)
 
 	hist = calloc(HIST_MAX, HIST_SIZE + 1);
 	if (!hist)
-		return -ENOMEM;
+		panic("%s: calloc: out of memory!\n", __func__);
 
 	for (i = 0; i < HIST_MAX; i++)
 		hist_list[i] = hist + (i * (HIST_SIZE + 1));
-- 
2.34.1

