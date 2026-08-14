Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DB8C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DC53812EC;
	Fri, 14 Aug 2026 18:28:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D4etKig5NZ3F; Fri, 14 Aug 2026 18:28:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8EF5980EF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732136;
	bh=gkk7aItW6bzDo65tFR65ih8jqgwHJ+pW4x+y/oNE33M=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iRiwZXLk7LB6PfjmPkopCgY2QhbY8KqtalnlNg4B+JJj28fn3fTnna5MYXlODaWk1
	 AMJHwe0CX1m2gM08KKH1vmcAyGpfOpneOo6Z1pSWmOM7FADP17VJ3T6ekgKQVYgS97
	 ybO3HJ3eqEykggzfyAiRAPLGL1bKMBlmTLHUkxO/kTOxrKLYeMqmG5eTioO/DkyGab
	 aUdJnFBrThQbotvNhpUEj8oTKD+d4bAdV8dVFMHy7JJLBjLImoH4lRYRMusEASgD9X
	 O/PgRrmDcVSaEbumzdGD6d7D5sriB2krK2jb8AyniJQA0STibP85Nh2OOtf9JaikVh
	 mJv0BHrcTLjEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EF5980EF8;
	Fri, 14 Aug 2026 18:28:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 49A1C3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B50340AE9
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuK7eOxtWq7O for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:28:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 53854409DA
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53854409DA
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oXWjY9rT
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53854409DA
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:28:54 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-92f0b5ed131so112342585a.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732133; x=1787336933;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gkk7aItW6bzDo65tFR65ih8jqgwHJ+pW4x+y/oNE33M=;
 b=oXWjY9rTs9mmAxe1isFSkA5qUbypH4H9ZFWt+gyYj470KJn/RkGAnvdQ89bFDIhyIg
 ENg4AncuFuONAARzePx/0S5NAXyfzPyMsTnpfERMEuc8o1bJDufYxMp9AwvDvyyuPoKl
 W0w6Rd7INHTEFZLULGeyODXR0tclr8FZ6F0OLY7AdRhaVocCdWbLorZPYsa3x0eLBhiE
 EHk8LmsrKAfAdf7TKIxrUizJiYEXynpYiuiYEPtG6nW5B81y8OaKYVgEHzBH3ti592KM
 BNA7/YkaB1Z4lOUluKBCIAXoT8adkBeQmRzJj6VQDg11bd6XxBsJNvLzWJszUIGIaJBA
 j7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732133; x=1787336933;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gkk7aItW6bzDo65tFR65ih8jqgwHJ+pW4x+y/oNE33M=;
 b=cEChEcv5hNlZREjuo63bRwGvddiFn44l8p6Yxef1YBnQyPbw+8YBiV2lOKo+ziINl9
 qxNza9OryL2fXFte+umwZ9fYkyRlpR/0N+SxnmrE90G23XULsMVIHF0/E8qEt5X8jGV/
 +DGWYd9+JxmJUCpxkJWIpM2TotqS5BEDg3h4PtL0ss4e7z/qWnPNhWpmKj8LueXOZ3c2
 Na6EDhJhRXX/+LWJCrorFerD4L4paD6rG6RgER26H5qfsEzxTITh2/H4VpnLMYZEHQ9h
 dL+W4m9xiuEkeUL3tdIC06RMbkTKb8xxuV+F16ccqEiN2xryaaxLh6mx6dKyIFlzIV9h
 f/Hw==
X-Gm-Message-State: AOJu0YyLeNfUsqESSMjtCcHvud4nV/jae3pBB71zqIDX9EMRuqlh3g0V
 tc33MtLmU1MFGCdQIFgOURUjKH2CDvHk85fyNOEb0YObnqIXVwYCKWo+KEz0HD9wgCiGd4jIztT
 Z/d6P
X-Gm-Gg: AR+sD13qHasEW6czuGfxY5GRmSTKjHO2iyqim2Auxr7/Hu5NZ7uS5eBW3lqoBSxdsOk
 qGYSOOam7DQmrmzE5EkqLGZJNiav7gSMe0f4ungueNKBkY9fUjmydnzuasNuf1kH1ZpO8zGDTF1
 JIfqlXtDxnpXLiFNUgvIU5w03ZznTIhrEcE+c1ZG1jS14cj37uLG3q4AcHgGEsoJtOUOz7sfthN
 zECLGCGlEPHYP72UMVIsnfB5lrRWO0KcjH2ybDKisgkfjPRJrfaoYXQVNXqW7KS+YXOJoNpalti
 9EdPGO9SJqHHLTuQQ7ZWWwJ3b5K/tWZq694dzhlTT4BCjJ0D4SBEkU3bJoRJlrFO/fPWqPJEIUz
 RMgGSzC4qss/NhovKIZt/ZIl8G33mUgpIrFHjxDE2NcAWX15Z36blzqRB+0wmN5SYE/hBinZKAC
 fyi6tOZMDik616Xo8/qcydq2hAi0xuWXH+fu0zk+feV2o8OkyOxiWsvQ3vJ9dVqyNoV6hl7yXHl
 9Rm+YmIedhW5TIOlrGSNXT3M6h28/lUPC7L+DqdeU5acvCFUd+sM8hRfNARYdDhEQI=
X-Received: by 2002:a05:620a:a410:20b0:936:adc5:6a8e with SMTP id
 af79cd13be357-936d22842d1mr683002985a.13.1786732132902; 
 Fri, 14 Aug 2026 11:28:52 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce24564asm336071185a.40.2026.08.14.11.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:28:52 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v2 0/3] spi: cadence_qspi: clock enable, compatible, write
 protect
Date: Fri, 14 Aug 2026 14:28:48 -0400
Message-Id: <20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGBef2oC/yXMQQ6CMBBG4auQWTNJ21QgXsW4kPIDw6KQjhoD4
 e4WWH6L9zZSJIHSvdgo4Ssqc8xwZUFhfMUBLF02OeMq01jLaY2WD7E1rItwQKjha4/u5ilnS0I
 vv3P5eF7WTzshvI8P7fsfAJAVEnQAAAA=
X-Change-ID: 20260811-rzn1-2026-10-spi-cec7e474ed54
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Anshul Dalal <anshuld@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732131; l=926;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=+Hzbkp7oSfz5h0kPBaqpmausuigBwgq75Mr2y4A0jUk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPHzUNZOA6HEfXjKho/KacTzV6usklQVgAsI6zkavr6gt27JkbBH3aih/WqaXNZpg8+h2fh1USj
 HLf5n2H7CJwc=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

1) enable the clock(s) before accessing the QSPI registers
2) add RZ/N1 specific compatible string
3) add an option to enable hardware write protection
   (TBD: maybe drop this change)

Both have been split from "Renesas RZ/N1 additional drivers" series.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Ralph Siemsen (3):
      spi: cadence_qspi: enable all clocks
      spi: cadence_qspi: add RZ/N1 compatible
      spi: cadence_qspi: Use APB write protection

 drivers/spi/Kconfig            | 11 +++++++++++
 drivers/spi/cadence_qspi.c     | 13 ++++++++++---
 drivers/spi/cadence_qspi.h     |  6 ++++++
 drivers/spi/cadence_qspi_apb.c | 23 +++++++++++++++++++++++
 4 files changed, 50 insertions(+), 3 deletions(-)
---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260811-rzn1-2026-10-spi-cec7e474ed54

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

