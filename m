Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B340606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HwfTPJat;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CoPPESwT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4864F80E47;
	Sun, 22 Nov 2026 02:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydjQXvX0CL3D; Sun, 22 Nov 2026 02:34:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 98B2F80E42
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795314890;
	b=KCDcwD4aIMtWC1kCK2Q5pBVniGkrMaO7Gf5MGwKTZ59Hh36hnfnZvavbxfx99/LMKsW9
	 fwZQ4eesaCZIr7nxa9k3fcdCTQcZdEqN4+scOMlGUEAUXF42QISXfvKY+d9wgKosz3l5p
	 mbWkdTGAchobOyIlaZYqs100OXA8Q0M8FmanFQScHsgwJ1E5h+VawukggZTjGaBy1N7H+
	 ZIirUyxUYuboNi3pUWu3pQTPqO8FNk10PcRagFSL8fYIKus7Ky+TTys3amM2S5t3kJ4hD
	 Yfnt16OIN1tEkI21r0W1EK20Ny19fqBX0nroGfxlcIWS5VQxHJFeMz2AwYn0GDoqVwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795314890;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LZztAjbtdTS2jNO9l1Vw2ZOqVuPqTiNeweO5d8vA3ug=;
	b=iCXyE/lxdDNbyCQ8e3Ro2Q/oezgvOrYTKrHF10hNj+rqhE7wvYjcRvh6WNqmPO/6YxHV
	 U+vvWgnVaXTZ4IAJGt+dPzV5gDfhy0vuO1qCF0uuM80/w3obMCp43eDVdTW+O7gZOS7/g
	 2QaFydLA+FMrnx4G83NHvC7pTPg3C6N5FAaveM9xm5QN58e0SWupuXT80gIP/OWF7Dwk7
	 FlutE9VmYoQHrERB7hz8udBybpOic2v37IM6O4IHX7gh8xyxnIQpHWy6KrexvpyPpQFL2
	 EMOYM6JEZo9AAQWw3GKzPE+qTqVjl65xnm6xzrbJcv7pfK07wqGnzkLg33W1mujusrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795314890;
	bh=LZztAjbtdTS2jNO9l1Vw2ZOqVuPqTiNeweO5d8vA3ug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HwfTPJat/wUP4PXa2hzxIeT6TwIO1LpoSKuuBbt10nS+32mT2akn97H5nmIkjaXFc
	 6CdFZo8OKUAhfF7Ldf+q3jkHV7vvdLZgfQQIgjFiHMVBOjDlKaKypgy9Xfh8Pxuo1Q
	 3Bp9+UTXqUwMC7+739n1TVkI8VFMxHEkzKt2/7SCcwvkZ+O40OajFVwkDlHlXk9K8h
	 zDtSPUQqrGfIr/VKP5YlDe1mTlFwukdXPhlJGJ91aSBQTd2569vhZZnpvwOfSJBhqx
	 bKZp5cfFJLy20SBoJYGstZ2iONI9WjVllOQeH36oylEa+JIp7xHDX+A4DZI2JdKhP/
	 +oWnHLmBK5ymw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98B2F80E42;
	Sun, 22 Nov 2026 02:34:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F419310
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65CC540176
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qTXHvo00nfRd for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 02:34:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 62FAA40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=CoPPESwT
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62FAA40012
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B8295455C9;
 Sun, 22 Nov 2026 02:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA171F000C0;
 Sun, 22 Nov 2026 02:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795314883;
 bh=LZztAjbtdTS2jNO9l1Vw2ZOqVuPqTiNeweO5d8vA3ug=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CoPPESwTIHxP7BG0c3qFDAepTPze0RDpzXJqKagZRk0XJ8IW3CqvFla6WrAwuITgB
 85edI0W827o+1Z5X8EAaBUJrOirnO4hYRkefwW4tijH+u7qTFQ/RWQw2ZCYxsO6lxU
 V3u4HNYS6SjKjmopVghC5iDGzmkI4/sb5hZC125zex3JuVPssEjkYn2NXmFI501D2Y
 BjUkzVt8PfaV/FMN7OG0B10FWeQ5wyBb0J4RepYbX787qYn5BI+BAz477Cgr+rYY7g
 4IhkngFSBxGBDPwS+NKfPq0lQGk2FpabyEJyted0sVa+/PaEuj2Ska9ITG+ZgI7Y4d
 JhhbVazmL3Ynw==
From: Yixun Lan <dlan@kernel.org>
Date: Sun, 22 Nov 2026 02:34:13 +0000
Subject: [PATCH 5/5] configs: spacemit: k3: spl: Enable boot from SPI NOR
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-06-spacemit-k3-spl-nor-v1-5-33beb921011d@kernel.org>
References: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
In-Reply-To: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=dlan@kernel.org;
 h=from:subject:message-id; bh=VeIecmP8bHBfbV0RT0jt782CxbjsWgPcBpUvqVQK/lg=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBrAlSzPY946+ToUOp07iGMxxxjZLlv/wKaWGr5j
 awhkZ10LEiJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCawJUsxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1I7xAAmtFjkABaHJH5/P1kzaDEbwfzelEuhZAdtMcC9RFtAdKVzZOjCOCB5
 nFs363i6+mn7yNnXlac8mNsTswbS7PI5YvwIstZLtClgriUdfCI/7wx+9vwNj9ZGYH4MNLoP/pH
 smAJW8WcKT/6LJgTU43w+VffftMNXEAhF6WicB5b+DbquEx8bg7rVWhaqwEBw2wO3q8qgs4NzzU
 VL67tObvebKB5lXA0OxVJgJYq2lDtyU73l/1G8mTgFwFEUlt5ez1qSOwb00BPicg+p+pCKZyOKB
 O2CTg4WK5CX8IFCOiM/coNzK/0ysx1NraFGp6T9bCuwOfb6awUnZf43jKPt5YZNZravY8NOLaju
 Jg1b69D2wPYfoRQvo0CjgmUl+s41TBS8nG+PBnvl8EvYgw9ZMrga93OvLM1bpGhT1/TGyG2DDgv
 R9Sj58h+NGIhYUVwsEvbmpBFlDNiP5QJX8rkl5RN9E67jFnzlFLprSnKbBZ5eOq5b8LxnvMoDKj
 Uoc9ok5lyUhleHi7Dl6vuz1I3jl9qCn35yC1QWdDRVUNYYBqXPyCfall/X6PK+x+Bbm8UGBMhDS
 dirQIXqz6FThOwr2nayXMlaRtCCuqw1R1y9syVC4rCaOHjE25lyrjJb46YL0rL4xarauLoisWYn
 Y5QkuiALoJKadJWrzTJUkgc/YDnhvs=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the driver-model SPI NOR flash and load the next-stage FIT
from offset 0x210000, matching the board flash partition layout.

Enable FIT loading and OpenSBI handoff to invoke U-Boot proper.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 configs/spacemit_k3_defconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index 9c976e83a48..aa20c80cf33 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -7,6 +7,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x102300000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0xa0000
 CONFIG_DM_GPIO=y
+CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k3-pico-itx"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x20000
 CONFIG_SPL_STACK=0xc0880000
@@ -21,6 +22,8 @@ CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL=y
 CONFIG_DEBUG_UART_BASE=0xd4017000
 CONFIG_DEBUG_UART_CLOCK=14700000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_TARGET_SPACEMIT_K3=y
 CONFIG_ARCH_RV64I=y
 CONFIG_CMODEL_MEDANY=y
@@ -29,6 +32,9 @@ CONFIG_RISCV_ISA_ZICBOM=y
 # CONFIG_SPL_SMP is not set
 CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x101000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
@@ -36,8 +42,11 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_BINMAN_UBOOT_SYMBOLS is not set
 CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
-CONFIG_HUSH_PARSER=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x210000
+CONFIG_SPL_OPENSBI=y
 CONFIG_CMD_TLV_EEPROM=y
 CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_CMD_GPIO=y

-- 
2.56.0

