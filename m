Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D88606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Yaf3tXFO;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gb6FU4Fq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26D64606AF;
	Sat, 24 Oct 2026 22:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 330eVmreebYV; Sat, 24 Oct 2026 22:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B24C460640
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881329;
	b=eBuuh9xioccD45Urmv/20F53nxjxn/h1rmh2YM9n0KrWIQ1+ds7jms9dOl6IIo46xDQ+
	 sXkzB7IeZDIM32UHDaEYnSRX5RbUoF95719abhA+ggOyMOcSxctorotgNRCBeR5ZC22Jf
	 CxO4VHdq+KEdEv0+J7ubWfOnk6u5y/cK4RHJ5qWnX34TQbMsD/eS0XPM6LzC+8XWfPjKV
	 9826BR7H3yw4DGg5KWjPaEcRPYlCDBkBfqux+SJkEPCkD+vWZhcbIdXWCMIi9ZkOvrdwc
	 mpEKeaGn4WsfzZTdkEKCb11ZblHjoHHUI+zRN5bS8EfMrMRO6k6MFOMfOTBNEQU1VcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CstRekT1JzhMwRMk7LQw+AzOJIxuBaqR0tQhHCIiSGM=;
	b=WnuhjrZl9tv7rneytfY39VbWRwaI04qkvyqgAxN9XtQMPYQSH4iCCVOh2/vFFSfS7o/J
	 CXZH/QZQ+S7J1+1n3NlUPMlCtTjOwtSiGuEqfoIvtzPY7uVJM9+l/NtEN2F4I4VX+0Dra
	 zxIbAs8KJ9O99+5XqlRfF5KiqG+1fJezmpBy6Ty5NHbusi3yqsmP35O6T8cMo4AUqJGbV
	 ORJSUYldgKtAFo+aZdVThaE1GRs+W3j10uMu87zfE4e8697vjB1H9LZa/zShr/cb+FKJO
	 wzyg0GyZbymfOrLfAXL1rzYmNTx6T29Yq5/jkkH982Q9S6xqiEqPwDEHinqblDTkqSA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881329;
	bh=CstRekT1JzhMwRMk7LQw+AzOJIxuBaqR0tQhHCIiSGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yaf3tXFO7SDnbiCBbN0FEPIWxG4r229amzaAh79zMxQJhiTJaGb9iewDdIKu0j6Lq
	 UCsi4kA1mbL/qLcYeQyw0fcptvANwrGcYTnf3EJiuo2dEYt7FAByorkviDlsj00ika
	 cxuFB15qqMF6OMPyTVmrg2KBMprMOdZuGLUCI82LAEUpUVRVVE+av316O8QwXDxdp3
	 fGhXms6QTjIoHToBlV/tKpB9U2/+Q75H2fJHHzG6FNgRMrENd8JBFnJv6xXLrVCNWf
	 GVSkaPHuW0DqppBpM+ThGuZ2qmiUfOL4v13dUF1W/oWfZFM4yIZbkKnLZGpSbjhph0
	 nPuNFZEzxGmzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B24C460640;
	Sat, 24 Oct 2026 22:35:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D8C83D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8374E406A2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f-mpEOfodJFv for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1175F406A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881324;
 b=Cr7aWxt8bvjX9nYSJeKBlLt1z36cfU6p2Lo2LaNxzJSf8dlPyUeJrwrdLzD8+mCQTCFW
 lrVc5WM0O586lmA2Rm3iIPbbJu+cxER0IUN7YUsmb9N2ndusnHAMKbbO9inncrOYQkYbV
 rYZCcA6CmsLMcHSthlEMGC3k219YeiNsibr4pkSqnsypvemks/OYgp97/43ujhSYpUgeK
 BoBk2OtyrjrAj0qU9FWo8Ao2HZxHfpbBLEMzKpgqtFi4DWz2P3k9gTrQEeUFTEPO5VNIu
 TI3qJSiU5Voznb5yCJkGhMYCQ6KPY1YtNGAR+lytx9k0dsmkOzdpZr0cOQ8sesNht9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881324;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=CstRekT1JzhMwRMk7LQw+AzOJIxuBaqR0tQhHCIiSGM=;
 b=BQU0JhXWouMaX6Z1YM/XgPH+Tzz0gEpMYN2JwLgcFJaj0N2nBjp1jJZzTIYI058qQkqW
 AvCvOAhVTtE9oDla0mvmr/NLxste4NjlwlAFlv3hAeGtkl+cOrStVcIOgJnEoQfo8a/la
 55EpEJ7slyWmx42bDY6DGIjoM4wUB3efH2l6zwc+kn00kLjPDWUpjDNDa3/r9CgBtHkKR
 NDXJysObPNpH9MuCRx/7z7y17P/QExJhhotJZb35vWQsNwfcIQTx9b3LIaHm0IfrVnOwl
 paOSCabJDO22I776iDJ80leo7QgVNkEY0DiSyiyF46K6MvrAjOx7aJLRHr23/hNfBlQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gb6FU4Fq; 
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gb6FU4Fq
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1175F406A0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:23 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-47b47de8b4cso1078393fac.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881322; x=1793486122;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CstRekT1JzhMwRMk7LQw+AzOJIxuBaqR0tQhHCIiSGM=;
 b=gb6FU4Fqpy9Dq29rL5Htb4W3jM/xCX7O0f0j3pAvGc5opW40ODGnZZNycqZ8+gTvwb
 HhmEYrZ8hThjey4w/TzOioi8jyp1qPt6Tatsd1J57yT8oRksXNCr7UXtj9Xrstsis7FP
 tw4AyaphBFXTiCJlpEZqYccbSG4HsBM/CYeL5jgoEtU/GyNRKZZyeyKM7Lnnh+VAWT2+
 BrkVP5kiznGG/5j8WKzB8Why+73cuGsjHDK3By7Ta0zkwFo487FL7rIe7YMa7ta3JCCI
 UDw+b4v13+sMi0HXYvZjryqeek3NlAzIoqeOWcMP9T6oNpN/Bap4VDB7SDg3lXaEWKfe
 7KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881322; x=1793486122;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CstRekT1JzhMwRMk7LQw+AzOJIxuBaqR0tQhHCIiSGM=;
 b=RvI0qo+nZB3LR9MQFry8ZRZXwZTKA9upfC7QnxKciKpP+AoruMQOt7/+CBNJr/ZvpK
 DX9a5of+tTmQGOq2gR6sCcoW6siDDjWVZKUEYh4vSVPr27+ZmKrq1hPBRKGjxw9JOze8
 bbaUWt0Ri56se1PHokEYZS5hT5gkEDiKMWuyoV/3VHEIGKYGNlSLD686xH1s9gV65Gu5
 lhC/WTrPz1w06tm0Q7WvviMfnrf/md4JZtSTd3+TlO74EIDKI8Hhgn6suBjKXwnVQOQU
 GJxqh2AxzfKjFxzErhJDMbsvNF8t/yT4F3HjXz6K+8vhW0TWFE7DBjSKJz/wXilL1mwn
 XPGA==
X-Gm-Message-State: AFq9FYLQP+YyXfyHYrO3h5ZUeVenyvUX0ZaocQWMjemqLYniGyKxx0LF
 ETwTwkEw7LmN3WlIeaI5pX7Bz6zKhKAZW6NKFDQmRcpJ9EhoBVU8OtSs
X-Gm-Gg: AYBFou39VL5Jnav4OQ+lEMUvS55DmLat/teOzscl0w7DiQFcj7A100NNQ19/eHFQbaz
 f72zvXLpEs45EENg/oqV7uNUB3c42vmyGhBotFuzAm7PRx1zYo0FjH6INN+AN4zuOJRt6/iaHtr
 uHI6Udjia7IGltlEkHGa5Ik2GVXX+lboqbEylxdt3ZuSnYf5NaDW7RMnRA/BEPDooiVooDlVfYA
 grMM0TbLw2xoM/hS9J9c4lLyKUb7q9ymrzn7aTXx2R9xpWNlC+/ApqzXOwdyxfFPFOU+CKKTaQc
 o5GhXtdpuqXZInQWhEGPaBmPcs2uwTcIhUK17O2BgG/wg3QARpbcvTTVvRf0r85Xztl0fhUr3Ty
 kgKG67Nb1s9QY19lb2xcHT1gvSDxXlgeSg1uRP4bBrv6GAzua4TKsuRRqzt4JUknf5KAbDn9zJ0
 shTTpn7BxuAI+ndY8B7JqzsfngZZhY4uK6H2Cx8EfI4BDEHCgFEGA4rcX3AHEgfYSzQQTglyN9D
 JZ+hmLWfoYo8rRpPcke9l6Sgx1z8pfjyX/5uY51/Du5Dz/ByNE5ORKSkniEPZMKwmbZOm5mTMys
 OdNz73prWn/DF+01B7Wvtpma2qelDuQ6ibCzLqvspMuf0aLUCqd+vpUgXIWEqQpyJByjvfQpH84
 X9HC1g0+9k0RWQdQ/EoMD4F76h0pbhhA9mjogyWynsEqi1aDlwuWWmKvhyEE57Yos7VKDcr8eNs
 zPugQ=
X-Received: by 2002:a05:6871:3321:b0:494:ad34:6b2c with SMTP id
 586e51a60fabf-4a83f53f738mr1886589fac.23.1792881322422; 
 Sat, 24 Oct 2026 15:35:22 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:51 -0600
Subject: [PATCH v2 04/16] net: lwip: tftp: add tftpput support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-4-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The lwIP TFTP core provides a write-request client API, but U-Boot's
wrapper has no data callback or tftpput command and CMD_TFTPPUT is
restricted to the legacy stack.

Make CMD_TFTPPUT stack-independent and implement uploads from a mapped
memory range. Advertise the transfer size, bound progress output, handle
exact-block and zero-length termination, and retain DATA packets for
retransmission.

Share the download parser and transport settings with uploads. Validate
numeric arguments and block sizes, provide the established
address-derived default filename, and avoid download-only fileaddr and
EFI updates. Read bootfile anew for each command instead of reusing a
stale DHCP filename from net_boot_file_name. Register both lwIP TFTP
commands as repeatable, matching the legacy commands. The existing
test_net_tftpput test can now exercise either stack.

Honor NET_TFTP_VARS for the block-size override. Keep the configured block
size as a default rather than a hard ceiling: receive blocks are bounded
by lwIP's fragment-buffer budget and the RFC 2348 maximum, while uploads
retain the legacy 1468-byte limit to avoid IP fragmentation.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig        |  13 ++-
 cmd/lwip/Makefile  |   1 +
 cmd/lwip/tftp.c    |   2 +-
 cmd/lwip/tftpput.c |   8 ++
 include/net-lwip.h |   1 +
 net/lwip/tftp.c    | 328 +++++++++++++++++++++++++++++++++++++----------------
 6 files changed, 250 insertions(+), 103 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index fda8568c9de..3e79920e7d1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2160,12 +2160,6 @@ config BOOTP_RANDOM_XID
 	  Selecting this will allow for a random transaction ID to get
 	  selected for each BOOTP/DHCPv4 exchange.
 
-config CMD_TFTPPUT
-	bool "tftp put"
-	depends on CMD_TFTPBOOT
-	help
-	  TFTP put command, for uploading files to a server
-
 config CMD_RARP
 	bool "rarpboot"
 	help
@@ -2226,6 +2220,13 @@ config CMD_WOL
 
 endif  # if NET_LEGACY
 
+config CMD_TFTPPUT
+	bool "tftp put"
+	depends on CMD_TFTPBOOT
+	help
+	  Enable the tftpput command for uploading a memory range to a TFTP
+	  server.
+
 config NET_TFTP_VARS
 	bool "Control TFTP transfer options through environment"
 	depends on CMD_TFTPBOOT
diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
index a60f8f35200..1050ee4742b 100644
--- a/cmd/lwip/Makefile
+++ b/cmd/lwip/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_CMD_NFS) += nfs.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_SNTP) += sntp.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
+obj-$(CONFIG_CMD_TFTPPUT) += tftpput.o
 obj-$(CONFIG_CMD_TFTPSRV) += tftpsrv.o
 obj-$(CONFIG_CMD_WGET) += wget.o
diff --git a/cmd/lwip/tftp.c b/cmd/lwip/tftp.c
index 6bb7a3733a2..2f4562487f8 100644
--- a/cmd/lwip/tftp.c
+++ b/cmd/lwip/tftp.c
@@ -4,6 +4,6 @@
 #include <command.h>
 #include <net.h>
 
-U_BOOT_CMD(tftpboot, 3, 0, do_tftpb,
+U_BOOT_CMD(tftpboot, 3, 1, do_tftpb,
 	   "boot image via network using TFTP protocol",
 	   "[loadAddress] [[hostIPaddr:]bootfilename]");
diff --git a/cmd/lwip/tftpput.c b/cmd/lwip/tftpput.c
new file mode 100644
index 00000000000..46e169aef2a
--- /dev/null
+++ b/cmd/lwip/tftpput.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <command.h>
+#include <net.h>
+
+U_BOOT_CMD(tftpput, 4, 1, do_tftpput,
+	   "TFTP put command, for uploading files to a server",
+	   "address size [[hostIPaddr:]filename]");
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 9edfb6e5f37..e67497bddec 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -93,6 +93,7 @@ bool wget_validate_uri(char *uri);
 int do_bootp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_nfs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_tftpput(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_tftpsrv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 61a3521c576..5347155120c 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -28,14 +28,21 @@ enum done_state {
 	ABORTED
 };
 
+enum tftp_operation {
+	TFTP_DOWNLOAD,
+	TFTP_UPLOAD,
+};
+
 struct tftp_ctx {
 	ulong daddr;
 	ulong size;
+	ulong total_size;
 	ulong block_count;
 	ulong hash_count;
 	ulong start_time;
 	enum done_state done;
 	bool is_server;
+	bool upload;
 	bool wrq_accepted;
 	u32 listen_retries;
 	char fname[TFTP_MAX_FILENAME_LEN + 1];
@@ -61,8 +68,6 @@ static struct tftp_ctx *tftpsrv_active_ctx;
 static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
 {
 	ulong store_addr = ctx->daddr;
-	ulong tftp_tsize;
-	ulong pos;
 	void *ptr;
 
 	if (CONFIG_IS_ENABLED(LMB)) {
@@ -80,13 +85,31 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
 
 	ctx->daddr += len;
 	ctx->size += len;
+
+	return 0;
+}
+
+static ulong tftp_transfer_size(struct tftp_ctx *ctx)
+{
+	if (ctx->upload)
+		return ctx->total_size;
+	if (!ctx->is_server)
+		return tftp_client_get_tsize();
+
+	return 0;
+}
+
+static void tftp_show_progress(struct tftp_ctx *ctx)
+{
+	ulong tftp_tsize = tftp_transfer_size(ctx);
+	ulong pos;
+
 	ctx->block_count++;
 
-	tftp_tsize = ctx->is_server ? 0 : tftp_client_get_tsize();
 	if (tftp_tsize) {
 		pos = clamp(ctx->size, 0UL, tftp_tsize);
 
-		while (ctx->hash_count < pos * 50 / tftp_tsize) {
+		while (ctx->hash_count < (u64)pos * 50 / tftp_tsize) {
 			putc('#');
 			ctx->hash_count++;
 		}
@@ -97,8 +120,6 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
 				puts("\n\t ");
 		}
 	}
-
-	return 0;
 }
 
 static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
@@ -132,10 +153,10 @@ static void tftp_close(void *handle)
 	}
 	ctx->done = SUCCESS;
 
-	tftp_tsize = ctx->is_server ? 0 : tftp_client_get_tsize();
+	tftp_tsize = tftp_transfer_size(ctx);
 	if (tftp_tsize) {
 		/* Print hash marks for the last packet received */
-		while (ctx->hash_count < 49) {
+		while (ctx->hash_count < 50) {
 			putc('#');
 			ctx->hash_count++;
 		}
@@ -146,7 +167,7 @@ static void tftp_close(void *handle)
 	elapsed = get_timer(ctx->start_time);
 	if (elapsed > 0) {
 		puts("\n\t ");	/* Line up with "Loading: " */
-		print_size(ctx->size / elapsed * 1000, "/s");
+		print_size((u64)ctx->size * 1000 / elapsed, "/s");
 	}
 	puts("\ndone\n");
 	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
@@ -159,7 +180,28 @@ static void tftp_close(void *handle)
 
 static int tftp_read(void *handle, void *buf, int bytes)
 {
-	return 0;
+	struct tftp_ctx *ctx = handle;
+	ulong remaining;
+	ulong len;
+	void *ptr;
+
+	if (bytes <= 0 || ctx->size >= ctx->total_size) {
+		len = 0;
+	} else {
+		remaining = ctx->total_size - ctx->size;
+		len = min_t(ulong, bytes, remaining);
+
+		ptr = map_sysmem(ctx->daddr, len);
+		memcpy(buf, ptr, len);
+		unmap_sysmem(ptr);
+
+		ctx->daddr += len;
+		ctx->size += len;
+	}
+
+	tftp_show_progress(ctx);
+
+	return len;
 }
 
 static int tftp_write(void *handle, struct pbuf *p)
@@ -173,6 +215,7 @@ static int tftp_write(void *handle, struct pbuf *p)
 			return -1;
 		}
 	}
+	tftp_show_progress(ctx);
 
 	return 0;
 }
@@ -197,18 +240,59 @@ static const struct tftp_context tftp_context = {
 	tftp_error
 };
 
-static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
-		     ip_addr_t srvip, u16 srvport, u16 srcport,
-		     u32 timeout_msecs, u32 max_retries)
+static int tftp_get_blocksize(enum tftp_operation operation, u16 *blksize)
+{
+	const char *ep = NULL;
+	ulong value = CONFIG_TFTP_BLOCKSIZE;
+	ulong max_blksize = 1468;
+
+	/* Keep uploads within the Ethernet MTU, like legacy. Downloads may
+	 * use the pbuf budget sized for full-MTU fragments in lwipopts.h.
+	 * CONFIG_TFTP_BLOCKSIZE is the default, not the receive limit.
+	 */
+	if (operation == TFTP_DOWNLOAD && IP_REASSEMBLY)
+		max_blksize = min_t(ulong, 65464,
+				    IP_REASS_MAX_PBUFS * IP_FRAG_MTU_USABLE - UDP_HDR_SIZE - 4);
+	if (IS_ENABLED(CONFIG_NET_TFTP_VARS))
+		ep = env_get("tftpblocksize");
+
+	if (ep && strict_strtoul(ep, 10, &value)) {
+		log_err("error: invalid TFTP block size\n");
+		return -EINVAL;
+	}
+	if (value < 8) {
+		log_err("error: TFTP block size must be at least 8 bytes\n");
+		return -EINVAL;
+	}
+	if (value > max_blksize) {
+		printf("Capping TFTP block size to %lu (was %lu)\n",
+		       max_blksize, value);
+		value = max_blksize;
+	}
+
+	*blksize = value;
+
+	return 0;
+}
+
+static int tftp_loop(struct net_lwip_ctx *net,
+		     enum tftp_operation operation,
+		     ulong addr, ulong size, char *fname, ip_addr_t srvip,
+		     u16 srvport, u16 srcport, u32 timeout_msecs,
+		     u32 max_retries)
 {
-	int blksize = CONFIG_TFTP_BLOCKSIZE;
 	struct tftp_ctx ctx;
-	const char *ep;
 	bool initialized = false;
+	u16 blksize;
 	int ret = -1;
 	err_t err;
 
-	if (!fname || addr == 0)
+	if (!fname || !*fname || !addr)
+		return -EINVAL;
+	if (operation == TFTP_UPLOAD &&
+	    (size > U32_MAX || addr + size < addr))
+		return -E2BIG;
+	if (tftp_get_blocksize(operation, &blksize))
 		return -1;
 
 	if (!srvport)
@@ -217,13 +301,22 @@ static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 	memset(&ctx, 0, sizeof(ctx));
 	ctx.done = NOT_DONE;
 	ctx.daddr = addr;
+	ctx.total_size = size;
+	ctx.upload = operation == TFTP_UPLOAD;
 
 	printf("Using %s device\n", net->dev->name);
-	printf("TFTP from server %s; our IP address is %s\n",
-	       ipaddr_ntoa(&srvip), env_get("ipaddr"));
+	printf("TFTP %s server %s; our IP address is %s\n",
+	       ctx.upload ? "to" : "from", ipaddr_ntoa(&srvip),
+	       env_get("ipaddr"));
 	printf("Filename '%s'.\n", fname);
-	printf("Load address: 0x%lx\n", ctx.daddr);
-	printf("Loading: ");
+	if (ctx.upload) {
+		printf("Save address: 0x%lx\n", ctx.daddr);
+		printf("Save size:    0x%lx\n", ctx.total_size);
+		printf("Saving: ");
+	} else {
+		printf("Load address: 0x%lx\n", ctx.daddr);
+		printf("Loading: ");
+	}
 
 	err = tftp_init_client(&tftp_context);
 	if (err != ERR_OK) {
@@ -246,16 +339,21 @@ static int tftp_loop(struct net_lwip_ctx *net, ulong addr, char *fname,
 		goto out_cleanup;
 	}
 
-	ep = IS_ENABLED(CONFIG_NET_TFTP_VARS) ? env_get("tftpblocksize") : NULL;
-	if (ep)
-		blksize = simple_strtol(ep, NULL, 10);
 	tftp_client_set_blksize(blksize);
 
 	ctx.start_time = get_timer(0);
-	err = tftp_get(&ctx, &srvip, srvport, fname, TFTP_MODE_OCTET);
+	if (ctx.upload) {
+		tftp_client_set_tsize(size);
+		err = tftp_put(&ctx, &srvip, srvport, fname,
+			       TFTP_MODE_OCTET);
+	} else {
+		err = tftp_get(&ctx, &srvip, srvport, fname,
+			       TFTP_MODE_OCTET);
+	}
 	/* might return different errors, like routing problems */
 	if (err != ERR_OK) {
-		printf("tftp_get() error %d\n", err);
+		printf("tftp_%s() error %d\n", ctx.upload ? "put" : "get",
+		       err);
 		goto out_cleanup;
 	}
 
@@ -273,12 +371,14 @@ out_cleanup:
 		tftp_cleanup();
 
 	if (ctx.done == SUCCESS) {
-		if (env_set_hex("fileaddr", addr)) {
-			log_err("fileaddr not updated\n");
-			return -1;
+		if (!ctx.upload) {
+			if (env_set_hex("fileaddr", addr)) {
+				log_err("fileaddr not updated\n");
+				return -1;
+			}
+			efi_set_bootdev("Net", "", fname, map_sysmem(addr, 0),
+					ctx.size);
 		}
-		efi_set_bootdev("Net", "", fname, map_sysmem(addr, 0),
-				ctx.size);
 		ret = 0;
 	}
 
@@ -420,7 +520,26 @@ out:
 	return ret;
 }
 
-int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+static int tftp_default_filename(char *fname, size_t size)
+{
+	const char *ipaddr = env_get("ipaddr");
+	ip_addr_t addr;
+
+	if (!ipaddr || !ipaddr_aton(ipaddr, &addr)) {
+		log_err("error: ipaddr has to be set\n");
+		return -EINVAL;
+	}
+
+	snprintf(fname, size, "%02X%02X%02X%02X.img",
+		 ip4_addr1(ip_2_ip4(&addr)), ip4_addr2(ip_2_ip4(&addr)),
+		 ip4_addr3(ip_2_ip4(&addr)), ip4_addr4(ip_2_ip4(&addr)));
+	printf("*** Warning: no boot file name; using '%s'\n", fname);
+
+	return 0;
+}
+
+static int do_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[], enum tftp_operation operation)
 {
 	struct net_lwip_ctx net = {};
 	u32 timeout_msecs = UBOOT_TFTP_TIMEOUT_MS;
@@ -431,64 +550,61 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	char *fname = NULL;
 	char *server_ip = NULL;
 	char *server_port = NULL;
+	char default_fname[sizeof("FFFFFFFF.img")];
 	char *end;
 	ip_addr_t srvip;
 	u16 srcport = 0;
 	u16 port = TFTP_PORT;
 	ulong laddr;
+	ulong size = 0;
 	ulong addr;
 	const char *ep;
-	long value;
+	ulong value;
 
 	laddr = env_get_ulong("loadaddr", 16, image_load_addr);
 
-	switch (argc) {
-	case 1:
-		fname = env_get("bootfile");
-		break;
-	case 2:
-		/*
-		 * Only one arg - accept two forms:
-		 * Just load address, or just boot file name. The latter
-		 * form must be written in a format which can not be
-		 * mis-interpreted as a valid number.
-		 */
-		addr = hextoul(argv[1], &end);
-		if (end == (argv[1] + strlen(argv[1]))) {
-			laddr = addr;
-			fname = env_get("bootfile");
-		} else {
-			arg_copy = strdup(argv[1]);
-			arg = arg_copy;
-			if (!arg) {
-				ret = CMD_RET_FAILURE;
+	if (operation == TFTP_UPLOAD) {
+		if (argc < 3 || argc > 4 ||
+		    strict_strtoul(argv[1], 16, &laddr) ||
+		    strict_strtoul(argv[2], 16, &size)) {
+			ret = CMD_RET_USAGE;
+			goto out;
+		}
+		if (argc == 4)
+			arg = argv[3];
+	} else {
+		switch (argc) {
+		case 1:
+			arg = env_get("bootfile");
+			break;
+		case 2:
+			/* Accept either a load address or a file name. */
+			addr = hextoul(argv[1], &end);
+			if (end == argv[1] + strlen(argv[1])) {
+				laddr = addr;
+				arg = env_get("bootfile");
+			} else {
+				arg = argv[1];
+			}
+			break;
+		case 3:
+			if (strict_strtoul(argv[1], 16, &laddr)) {
+				ret = CMD_RET_USAGE;
 				goto out;
 			}
-		}
-		break;
-	case 3:
-		laddr = hextoul(argv[1], NULL);
-		arg_copy = strdup(argv[2]);
-		arg = arg_copy;
-		if (!arg) {
-			ret = CMD_RET_FAILURE;
+			arg = argv[2];
+			break;
+		default:
+			ret = CMD_RET_USAGE;
 			goto out;
 		}
-		break;
-	default:
-		ret = CMD_RET_USAGE;
-		goto out;
 	}
 
-	if (!arg)
-		arg = fname;
 	if (arg && *arg) {
+		arg_copy = strdup(arg);
 		if (!arg_copy) {
-			arg_copy = strdup(arg);
-			if (!arg_copy) {
-				ret = CMD_RET_FAILURE;
-				goto out;
-			}
+			ret = CMD_RET_FAILURE;
+			goto out;
 		}
 		fname = arg_copy;
 		end = strchr(fname, ':');
@@ -517,21 +633,20 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 	}
 
-	if (!server_ip)
+	if (!server_ip || !*server_ip)
 		server_ip = env_get("tftpserverip");
-	if (!server_ip)
+	if (!server_ip || !*server_ip)
 		server_ip = env_get("serverip");
-	if (!server_ip) {
+	if (!server_ip || !*server_ip) {
 		log_err("error: tftpserverip/serverip has to be set\n");
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
 
-	if (!server_port)
+	if (!server_port || !*server_port)
 		server_port = env_get("tftpdstp");
-	if (server_port) {
-		value = simple_strtol(server_port, NULL, 10);
-		if (value < 0 || value > 0xffff) {
+	if (server_port && *server_port) {
+		if (strict_strtoul(server_port, 10, &value) || value > U16_MAX) {
 			log_err("error: invalid TFTP destination port\n");
 			ret = CMD_RET_FAILURE;
 			goto out;
@@ -540,9 +655,8 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	ep = env_get("tftpsrcp");
-	if (ep) {
-		value = simple_strtol(ep, NULL, 10);
-		if (value < 0 || value > 0xffff) {
+	if (ep && *ep) {
+		if (strict_strtoul(ep, 10, &value) || value > U16_MAX) {
 			log_err("error: invalid TFTP source port\n");
 			ret = CMD_RET_FAILURE;
 			goto out;
@@ -553,14 +667,12 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (IS_ENABLED(CONFIG_NET_TFTP_VARS)) {
 		ep = env_get("tftptimeout");
 		if (ep && *ep) {
-			ulong timeout;
-
-			if (strict_strtoul(ep, 10, &timeout) || timeout > U32_MAX / 4) {
+			if (strict_strtoul(ep, 10, &value) || value > U32_MAX / 4) {
 				log_err("error: invalid TFTP timeout\n");
 				ret = CMD_RET_FAILURE;
 				goto out;
 			}
-			timeout_msecs = timeout;
+			timeout_msecs = value;
 		}
 		if (timeout_msecs < 1000) {
 			printf("TFTP timeout (%u ms) too low, set min = 1000 ms\n",
@@ -569,12 +681,11 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 
 		ep = env_get("tftptimeoutcountmax");
-		if (ep) {
-			value = simple_strtol(ep, NULL, 10);
-			if (value < 0) {
-				printf("TFTP timeout count max (%ld) negative, set to 0\n",
-				       value);
-				value = 0;
+		if (ep && *ep) {
+			if (strict_strtoul(ep, 10, &value) || value > U32_MAX) {
+				log_err("error: invalid TFTP timeout count max\n");
+				ret = CMD_RET_FAILURE;
+				goto out;
 			}
 			max_retries = value;
 		}
@@ -586,8 +697,16 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
-	if (!fname) {
-		log_err("error: no file name\n");
+	if (!fname || !*fname) {
+		if (tftp_default_filename(default_fname,
+					  sizeof(default_fname))) {
+			ret = CMD_RET_FAILURE;
+			goto out;
+		}
+		fname = default_fname;
+	}
+	if (strlen(fname) > TFTP_MAX_FILENAME_LEN) {
+		log_err("error: TFTP file name is too long\n");
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
@@ -598,18 +717,35 @@ int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto out;
 	}
 
+	if (operation == TFTP_UPLOAD &&
+	    (size > U32_MAX || laddr + size < laddr)) {
+		log_err("error: TFTP upload range is too large\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
 	if (net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT)) {
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
 
-	if (tftp_loop(&net, laddr, fname, srvip, port, srcport,
-		      timeout_msecs, max_retries) < 0)
+	if (tftp_loop(&net, operation, laddr, size, fname, srvip,
+		      port, srcport, timeout_msecs, max_retries) < 0)
 		ret = CMD_RET_FAILURE;
-	else
+	else if (operation == TFTP_DOWNLOAD)
 		image_load_addr = laddr;
 out:
 	net_lwip_stop(&net);
 	free(arg_copy);
 	return ret;
 }
+
+int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	return do_tftp(cmdtp, flag, argc, argv, TFTP_DOWNLOAD);
+}
+
+int do_tftpput(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	return do_tftp(cmdtp, flag, argc, argv, TFTP_UPLOAD);
+}

-- 
2.53.0

