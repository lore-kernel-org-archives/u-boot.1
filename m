Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEDFC79F85
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 09:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 886E360619;
	Sun,  6 Sep 2026 09:32:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aq_GlTXLUfoZ; Sun,  6 Sep 2026 09:32:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9121F60609
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788687133;
	b=gQz++DMMuHrOrapWHfLzP81erXenjXRJ3yXf0PGD4ScVo02WIv/pBS93IzTsmz3T9Ip4
	 0V6en4Re1+wjrEUqWMYC+jAI91F4PJEnABe535EtusW46XvkhcSrBnh6dUW2nJS5ps31z
	 5/zezK0U1DGMhvC4t/TGgwOj2Ly7kGV5YJconPm9wCwAKP0jvXixaGgKvW9BiuI7kcvWW
	 PbXWDqlWwfECmA31i+xWG4ZbZwsFiGA5zFn6P59yHio1E5SXgaOmCezQixoEJ0joMwD3A
	 MmDjdx8CuZxtJoUep0ZJ8M+qCUC01cQLiKTS+fISjNUWkwkNlXLLTuQyU1tHXraaGiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788687133;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9sIgGttVlLo6CdJdFKbgHxXL6FDKcmp+tHraTd9jtSQ=;
	b=RypgLGinMP4x3aP3h4J8o963C4/82Y+dUuolN31zjg+iR2NZ/c6irWcZtGP2sUr91s9b
	 Ng86WIdUWktXZjWI7Iv8/KhIo1qmSmq342DdfQuhunCs27mau4+07J7NYraScrSuKEukf
	 AbsZzlGwYYZlnXqgkMh4BfYwIkh2fNo+wqJ6qkJTiPCcgOtAVZSYUAEg1VuLguvcBkmAY
	 Ie0vYEfGhIwlk757/3dC/1tPbfix1SW+3y+7Ot6nGSHca9FAXy1t5ZoPN96MZVhYKMDGr
	 +8kpA6KFO0gH22F8oODdlvbNuIU4MNnlsOGlNRgtWnddFw6TxziPfvKKBqvbHfl6dlw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788687133;
	bh=9sIgGttVlLo6CdJdFKbgHxXL6FDKcmp+tHraTd9jtSQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HWokzMFAi2pqLGf5tLnCjum477f+Fd7R/a55MfftjpKfG7KeMcdUGdE4ZjDxuJXOp
	 ktj55w0S6P6iM4RCAmPXxwwQD5YdQgqVqo8lZn6bo6jVARNTqVB8QL9531JFsNGS3m
	 atjzgR0jDVlt+udRQSQ/PVLbUH7Aoi6NR4Z1u1G+D/irBm866+knoknXfPDmWxfIL6
	 TzqRsWSh675N6/MXjPapvYFGwRAxFVd7zUrdPa6mjrwBPKrQrLenX62whTi6AQc/9m
	 hCG6lqCjHnuGAZI4LYEES4ZDSK7q4jMhKkPjPJPqXLJthUsvmjjUlL98h7WtIovSXq
	 bzEB/6vzvtxdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9121F60609;
	Sun,  6 Sep 2026 09:32:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5011A72C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35D214008C
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:32:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vb9np1mv7TJW for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 09:32:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4EA024008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788687129;
 b=bsDHb/YJVd9N7WDK7iSxaZrwc83u18i1RcQas9fiLGlS6JreOmFj30NIT5QxAx/BoEtw
 yLdHd4YUwUxYCq7Az9Vw23E6ns47Rczl4NNbWSAJJ5TA2nvM+SarNa9UGmqLPrJH2ye15
 X6FapHDC6KDHoCxOHy1nSjhrdrMk4NxECsMVZELpMW8AEMOZUgU633utkeAD293A9CVLd
 35ICdfcVA/CNID4rWrQNK0oOsknxGZOiyHQQErhTaWA2S74R4hplj3Rw5CqQQCY0Mvspm
 55K164SSKAWjhBaiTR8nHluTS84DTtYBRisR7mJG4MZQwYN3syzfUcyJMCeC7dTzWhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788687129;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=9sIgGttVlLo6CdJdFKbgHxXL6FDKcmp+tHraTd9jtSQ=;
 b=bplb8lXaMmg3LlIpQ9WjkVjquyTVO7qk0gLySRuBaHilGzm0ngqzbNqZ5eGoi/JBBC6h
 NfdlsAoih9MwD9Sv4CilEfZITX9drNVW3MlHWw4Vdxz0vgBzkIShsqZD+H2Dv3Z3gaaok
 4y+U3NCxzAe7zI71X2exHc/THxNbBGO3rpEXnhEo+w0Ac8AzpRks8r8avh/o5jNWh/GW9
 32maylnX0ete+oUkx2q6rQjh8wI2kzBsX//QlCM4v7lr24WLI1OIztoyN1o6GfIDMw8Xl
 lIcKadOcnfEnSjG29RchlQOmQgszwXJGt7O09ftxCThrtOPrXjLVqIVxZnRIFx8ebgg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=djin8FAj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=djin8FAj
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EA024008B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:32:08 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so2081919a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788687128; x=1789291928;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9sIgGttVlLo6CdJdFKbgHxXL6FDKcmp+tHraTd9jtSQ=;
 b=djin8FAjnvEFFJq7DeEmFQMTf2SDIRQ2VqIxOJTgn6eZmjp+X/WZm16wXLE1eBRH0x
 Jf3nCFLYaVs5bti5mGyvA3yFRnLOpyrPMZ69qQyOCKgv3tkDHe8mGPV+5NGBLxSFHndC
 +SRmf6+mFNDyjfgU86++3tfD29yTGM+pz1egzfLPwZrZyi2/ccfKm6OMtjw4ek/slA1E
 +R7CD5g2kV+iwrwCyYL2bW0OBBkpba4pa9nacoUARak3msp0mL6C+UT9Yajbkkt0nNXE
 nRipq/n4323ZOdlNkdBpIZ4MlpC6fiiLjWbcGFM21KswRZImgPUPB30cS+nzjJiaRS7X
 xXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788687128; x=1789291928;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9sIgGttVlLo6CdJdFKbgHxXL6FDKcmp+tHraTd9jtSQ=;
 b=nWdHQFo9kdjTjmU/CAWSRdYLG2EfEbPItMQPqTyX1etl0ZI3PvnO1O3TnzwJsyGfUC
 OUYvGQ3JQMmI1xj/CoFOp9OuPwnUhFMiykdtBoE64eFyYZ60O3s/Qn8EMaLItAwxUTOR
 wPFOlWKhsj3NrpMyubMT22uAQt4lB9YAsp/NP+E6K96OvNKd8RnXzdJQKFyvQ1F3MupW
 NqFsLarQcNQqHvXlBRQgKiB41A8bbNr6HiFFHZcuWk4TnCo7VweynO4/i8t/yvF37Csn
 SK1UOlk/aWR51PTtcnr0TEJ/0ZMulxKYwQhkJIf9nfO+7/m1xs0tTfV/fqPIoiwTBFO/
 cKpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvhuBSrj9jZuAa2vxF0NzuIyzoYeeLpNrYz7gJJZhGH4RvWrGomnrnp8u2aHlNWOuMrdFKJ+g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l2pzbyWTXMCj+KoqXVVOP6okr4AWLnk7vuoUl8QUuVJ4f1p6QK
 23YlUjLnCoAdWwKkiWBUHdclSn3pY/pVWuW6wcEJ+q0VxtnaxzGK31qQBraCIfVp7m0=
X-Gm-Gg: AYBFou0pv6/G35c3Mo4nBDX/WweIh/PIpdebeBrW/PmkTv/mDisJ+wMVrEfNYP231S7
 VObRM3mxreLa79qRh8EVz3Bo4+avjQZDz9tg8DkI3LYa1XcALLDof+adCLc2vw5gPmKxBifN706
 PvrORXSGYFFaKeW1+ZVO23sM3HdPXj6vQADmKlFiI1kBRfWD4/8jGYtGZniLTWFF2ZggpHYtoBi
 7T4T+/5hXl94P+A7xrXxXeyIsPbROiNG6j2LH9P57SSm2SxQBcHkHZPVNoZuMfSElv4Oj66MUrL
 shepBovPl7LMmGtII56C5QmsY0NXkT0qP9ZYPL3vm2P7RpWMKZo2xobTE6VpMQPDVH1fYhmWqyj
 Prnik3cwMKUvOPJDIwstI7m/0kAO1YH1ZNvCjBnpNCO4dHRx+6w1z0VaOkHA4lZF34Z2EGiOqIn
 auGrmBwgE8tM/ViM09JIfXbGwxsQGZXz+EWTbhti1vKxLto+Av2wgsG/HTlLH1NTx09J+xgpRR/
 rEu+ZCe2LOmQXEbqEMxJCXByUO6WxhS11dzmZ5uuPolGNX/za6HzNqHT4++ovSuVZjzwQeXAbJn
 yHHk9rXTdTnD6amKvj11JD3mow==
X-Received: by 2002:a05:6a20:6f8c:b0:3d3:ae0f:5269 with SMTP id
 adf61e73a8af0-3da3a15c001mr25521095637.21.1788687128212; 
 Sun, 06 Sep 2026 02:32:08 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa33e96sm19210761eec.12.2026.09.06.02.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 02:32:06 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH v2 0/2] pinctrl: fix on Spacemit K1 SoC
Date: Sun, 06 Sep 2026 17:31:58 +0800
Message-Id: <20260906-pinctrl-v2-0-729da680092c@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA8znWoC/2WNyw6CMBBFf4XM2ppSHzxW/odhAWUqY5SSmdpoC
 P9uwaXLk5x77gyCTChQZzMwRhLyYwKzy8AO7XhDRX1iMNqcdWmOaqLRBn6oIi8dnjR2lSsh2RO
 jo/dWujY/lld3RxvW+WoMJMHzZ7uK+er9V2OutEJtsC+wOujKXZjESmh5b/0TmmVZvpmushuzA
 AAA
X-Change-ID: 20260824-pinctrl-718fe50eb9f8
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Yao Zi <me@ziyao.cc>, Huan Zhou <pericycle.cc@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kenrel.org>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.2
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

- Add IO power domain control register programming via APBC block with
  ASAR unlocking for dual-voltage GPIO banks (3.3V/1.8V switching)
- Fix drive strength configuration: use FIELD_PREP(), preserve io_type,
  return correct pin number, and remove redundant initialization
- This patch set is split from the spacemit mmc: https://lore.kernel.org/all/20260819-m4-v9-0-6e66016392b9@riscstar.com/

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
Changes in v2:
- pinctrl: Add review tags. And update a few on coding style.
- Link to v1: https://patch.msgid.link/20260824-pinctrl-v1-0-e02ed7e9309f@riscstar.com

---
Eric Chung (2):
      pinctrl: k1: fix drive strength configuration
      pinctrl: k1: add IO power domain configuration support

 drivers/pinctrl/spacemit/pinctrl-k1.c | 109 +++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 7 deletions(-)
---
base-commit: 75df64103873fac09642860cedadaffb8cf6b2c7
change-id: 20260824-pinctrl-718fe50eb9f8

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

