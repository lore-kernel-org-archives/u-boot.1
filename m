Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B47606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q5kfEXyX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD5DC40852;
	Thu, 19 Nov 2026 12:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nOr3yEE9a3Xx; Thu, 19 Nov 2026 12:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F182E40810
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795091764;
	b=VPs4bRXxODHYICxYHQgTsrOEmlFRe5cDr9ndMr+Ux8EPCzsIfuBpbsVKS++3pJfGYK2M
	 Rtg0p8jjcnF3VqH+wpbmTlDdEWeH6TI/X1sNE7YppAG2MswXKJQ94lMvu3J2/BBXiiH34
	 rS+G79Fki0NzcglT68amPx+9YzuTPJwe7kSXcnUfvVHy+AfwIaUi0U4PU4Iv+Ltvsnzvi
	 hzJZWRDKuzXTYFAdhSNosxt5cA5zQ7Moa/99tE8Xzjb9z0L6MNiD+0EyIGWdm5XoCoq8e
	 m4wV3gncSpNQD3M7SVJMFlDCN4pgIZPpRrEN50yvccAx9xQttqxFbMOmc0iZeNaYwDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795091764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-QQ-mid:
	 X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:
	 EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2ZHnID6nP+kTrCrreEFuQdZ4YAMHUQxjb9HT4cY74y4=;
	b=JV7jGH12VQmBgkEIDt35abGLKq9fP32n3TXuu5gRz2PV1EFjEm1XjnlLIJ+DvhZd7nz7
	 i7NVkpCuPfG3D96nmSetR2H7Io+TRPVIWOEmGgKHVGwyGgCH5h5s+H5yv8kQulvPUfsJu
	 bfQvlOGaxEJmZmjfPx+x4ItLLnknCwW74VDMlRMdIRt1TYDRtMnxCfM2j8uRraKVE6+tw
	 pjfURox2oR7idhve6trEoi4VS7WIKylwXT4O6Ql5FGP28+TOPaKSH1WWw6RQ37m8egsue
	 gjBTlLY14lrACP95FFSzcVWV9+bPveL6sNRv0gamK75tC0gO47wdlQ+URuNUdzSClhg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795091764;
	bh=2ZHnID6nP+kTrCrreEFuQdZ4YAMHUQxjb9HT4cY74y4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q5kfEXyXuL/GCDKTeIH21b0/FE+zBB9fhenwwVpIwRh+YsW3kcykGnOf5co41wc+W
	 KN1mySx4/c0J11mrZwvl3BZ6teVZUIgCYLjWCyaZHO5FPOzEJf/bPY/Sk8AtC9kDa/
	 veLFXwK3FOoNS+q/c39dID48rokjeET3M2q9GBhZbwVQYz/yRPn1sjriCIne+CRZVK
	 KCSIlctMqE7e1Z+THjXKUPnfj4UVYQJ2/3rC8JUrJkwtOJOrIsYv9eokxRkAp0kbMt
	 lBkNq0Z60YPdAogk/s7y2/ldvkksiiZ/Q8ApL/6OLDymjJASl07D7pAEnzZCQ73BK/
	 rK7bf8d6Vsu2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F182E40810;
	Thu, 19 Nov 2026 12:36:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 10CCC2FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E35F81310
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sf0fbOu322VF for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 12:36:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D885E812F9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=114.132.58.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=114.132.58.223;
 helo=bg1.exmail.qq.com; envelope-from=luojia@rustsbi.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=rustsbi.com
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D885E812F9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:35:55 +0000 (UTC)
X-QQ-mid: zesmtpgz8t1795091704te5a37934
X-QQ-Originating-IP: +vHOixPUvBo7LmmSfmS4imLzbDfnWJPE64g8soBn3As=
Received: from jiangzhouqi-ubuntu-4090-01.. ( [36.110.52.2])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 19 Nov 2026 20:34:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1013508859816826133
EX-QQ-RecipientCnt: 12
From: Zhouqi Jiang <luojia@rustsbi.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Maslowski <info@orangecms.org>, E Shattow <e@freeshell.de>
Subject: [PATCH v3 0/2] riscv: Document RustSBI firmware support
Date: Thu, 19 Nov 2026 20:35:28 +0800
Message-ID: <AEF561F2E6C94301+179509169842.3130233.16129671820912856303@rustsbi.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:rustsbi.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N6euzTYZA5gviPeopw6e3bKKyoPamCMSbPDIQG+wJIoA03BUQ17RsUzI
 5HBZ0CHDRuz8pa5MdT4+Ic2rpxIyjClLekmeQVvkv4GvfmEAK26U925oEqlNhCxET9avL3d
 BaxX7RcXeyJNDuFv+HEVGErvl88pVs9F6NMzIB3Uxb8cTFq5H/VZdii0kVnDHh1Pmlrk43v
 1sqicbj51FCHehpOmW4UZso6xBBCYUp/IlBUIE6RF/WiNtpM0hBUmAvQp2R75XvdGqhywjw
 nn0pQW65gSP3AybToYps/wuZZ7ATg4fuy/VMqjyT0zb4wNIgzsa6vunS+AHvkF5UWR+cihN
 FozXQaCPh/EbH2KBVYELEuywQeJHjsesXpBWcHiysC65VpMIABxC9kILXn0AG6ZUhMU1y67
 EGdu/d7K+L/L1nTC2pjWELFFKIUDvLcgyT1/HgAVbCogrpyLTW3cDtnYQDrUG36Fu1N1aSI
 dhLPxslQceNrdaIApsrOt8H4/Eo0hCvUCxMW59F2GJ/2ah2B0va+xyWvK0xbf/9AOCSC7GZ
 YGoQnfkOFh3JsNjZ4j65WbxUMJTZcTWvFH0WKRaIVVvUsCritK3VNu37s5wfVR7N/1C2351
 PAvRt9lCFtciimZuaNk6uYJSsEtXpui/PejwsXt8hAHW8kDmhGeLN6q+zr65B6CP29XCcoI
 7fSlCgjcHLGeQjjF9lUd6x0NMvH1VYEdmx3oPIX3d6Mkgr39023+517G0enXz1sAVKaogwH
 klWElBZ/GznexUapUOHadpOwI1yP9O/xKn+5uPp2u+TXjq79tZdHQmJWqe909aR0goGpdKD
 YAZAt2t2bziU3w8d7x07JVhLziK5Idu14yXoQ/7L9IaHETtfg9aC+wDZvOHax7hZ+GhjK7D
 Dtx4GY/fOqvDlhVTNqL+7OvRuTj/SW+PA5ruOmMpYPJTH0Nvv4I3mO1nmzLMOxUMwcGfO1X
 8RRLAsYl+Dj+Tx3CgMcMPaWc1n11LzRNnVXBIDQTyKYIuhN8o97I8n1QgrYvS3UkstUMmZB
 HAySgFG8mvENw+FTjWT7hK9NXIy75thA1VTUqrnjScL80142/cm560bL7a5ZM=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot SPL can start RustSBI dynamic firmware through the existing
FW_DYNAMIC handoff. Document how to pass the binary with OPENSBI=,
alongside an independent update to the SBI_V02 help text.

Thanks to Tom Rini, Yao Zi, and E Shattow for the feedback on the
earlier versions.

Changes in v3:
- Drop the RUSTSBI= alias patch, including its binman test and help.
- Describe the SBI_V02 requirement using the SBI version.
- Document the existing OPENSBI= input, the board load address and
  how SPL passes scratch options to the firmware.

v2: https://lists.u-boot-project.org/pipermail/u-boot/2026-November/641115.html

Zhouqi Jiang (2):
  riscv: Describe SBI_V02 in terms of the SBI version
  doc: riscv: Document SBI firmware inputs

 arch/riscv/Kconfig |  4 ++--
 doc/arch/riscv.rst | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

base-commit: f6e8f09ed39347359ebddd983b96993c78b4ec7d
-- 
2.53.0.windows.2
