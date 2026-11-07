Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A233606A33E
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hP0ddKkx;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ewpajCHY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7C9A4078D;
	Sat,  7 Nov 2026 16:07:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VkVZPrENw-Se; Sat,  7 Nov 2026 16:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 292E340790
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794067641;
	b=JyiJHu81wNfINXTxc2iLbPyCeQtNmsq878wBLkvbeeo8ke1We4IN5YWrZz2jALO2GAX3
	 EABBPeF+VtfPKZxZKfqoTz4OGKGwsBeqL/jTkaiKmIo/83F8JurFh+9PGObh+gQyoVIjy
	 /W7vXELkGc+UboSVVH6GsF4YgmEPZq4ewA426FADWLLkUXV/tZexU9hUchG1uSNt1Foy3
	 TOGLhBvic3kdkobV6IO1MqCvhGHxVmgesN4wE4wH0MsJVYmQDD0jJP6OM5xwEF6WfgaCG
	 RaENqF1kRb9dGLMUCXb4vacb3kwk1MuNI34vXDZWiU0UnuJV3E8SDEi3XpTJjWvNguA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794067641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=skS66Bs9bupxnSPXpo1hOyJIBEuQVCpruTlp0veni3U=;
	b=TToLG/V3LSvrwsRy/FWYxmSzYKDks0bw/9amu2Z8kK5wdSd+IzcBbH6ia4Zkt2eu/d6o
	 rcgK1t73XDMicadLeB01Am+RecR+Oth/UPyS/Q+DaF0pwhiwJREP0jzdYkVqrj7xlipm5
	 nB9cl1yJz0eFZC6iM8otXMeU2IhmyJ5Dou/aNtatcfgz//E6GKYT4K2sCDP4h5Sam+Nvz
	 n3hMhSfTIJCXKhE+V0FglvZqdbQh5nOPPo/QOueGOL4lmZYZchBbWUDM465rR1CFx631A
	 5CCrLLdJDQ4VReU8n4uofMt7DMQua53XFJwF3MYR0XoCwpFecpFPsjwLAdUGep3NoKQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794067641;
	bh=skS66Bs9bupxnSPXpo1hOyJIBEuQVCpruTlp0veni3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hP0ddKkxU+nvta6ym0Ak6hTER/cVzw0FmceCQPYqFdcOpG9oYfxHGRUj2ZG7dVSJg
	 tMapNveTACBlNEAoVQD+st1+tNHLKzZh8i9Zx3rBSpvSBLR7pA/HF9UKcguMp0iXXY
	 XVxxUqGaFWzLOjPJKzQl4PGs0QN7ZbOja6V9S5Tja/o+o0K17cb3atXlMwfbW5c2f9
	 b7K+jPbwYeACYdWy1jhVYZu+15YSAee7kqw4hwsKO9lNjcxDkmDXiZ4/4fbgCbTA6f
	 /GkgteUg+LvLN1+MXMF9KuyF/Iw+3UN4NVH+LiFxuglpksYgXX6Pf08fhpK7bqy5nq
	 m0vfL2I/sdrsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 292E340790;
	Sat,  7 Nov 2026 16:07:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 14BFE37D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0658D400CD
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:07:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zRNE5qmEtbiy for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 16:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DAAFF40050
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=220.197.31.5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.5;
 helo=m16.mail.163.com; envelope-from=hyyoxhk@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=ewpajCHY
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAAFF40050
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sk
 S66Bs9bupxnSPXpo1hOyJIBEuQVCpruTlp0veni3U=; b=ewpajCHYX/+a5sIDJp
 Yf3uGEPKUNGa15/Q0Ibgg8YGvV6ePJaEZZ1AaxhqeMmB7NwUgUk+JlggJb20ZY0m
 X2UllBcGnRvB7VzoS3p5y7CoIWGhKwsDvat2Tp6nhmdz1jkSmOG7r2mLtgK8SYfF
 S1fqMsD0n060bx+9dOjbgBjqc=
Received: from nh50.. (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wA3FCH3S+9q+f2SFw--.1483S4; 
 Sun, 08 Nov 2026 00:04:08 +0800 (CST)
From: He Yong <hyyoxhk@163.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: [PATCH v4 2/5] bootstd: Export the script bootflow execution handler
Date: Sun,  8 Nov 2026 00:04:03 +0800
Message-ID: <20261107160406.3943071-3-hyyoxhk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107160406.3943071-1-hyyoxhk@163.com>
References: <20261107160406.3943071-1-hyyoxhk@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3FCH3S+9q+f2SFw--.1483S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1Dur1DGF4fJF17Ww45KFg_yoW8CFWkpa
 nrAa4fJrWkWF13W345Cw4rW34Skr4kKa43JFy8Xw13tr17tF4kJF1ak34rtr15XF95Kry5
 uFnIvF9rJrn0grJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDtxfUUUUU=
X-CM-SenderInfo: pk1105lkn6il2tof0z/xtbC8hinemrvS-guagAA3F
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make script_boot() available as bootmeth_script_boot() so another
bootmeth can reuse the device environment setup and script execution
without duplicating the filesystem script bootmeth's handler.

Signed-off-by: He Yong <hyyoxhk@163.com>
---
 boot/bootmeth_script.c |  4 ++--
 include/bootmeth.h     | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index cd50977cc40..9e95cc51e58 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -188,7 +188,7 @@ static int script_set_bootflow(struct udevice *dev, struct bootflow *bflow,
 	return 0;
 }
 
-static int script_boot(struct udevice *dev, struct bootflow *bflow)
+int bootmeth_script_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	struct blk_desc *desc;
 	ulong addr;
@@ -258,7 +258,7 @@ static struct bootmeth_ops script_bootmeth_ops = {
 	.read_bootflow	= script_read_bootflow,
 	.set_bootflow	= script_set_bootflow,
 	.read_file	= bootmeth_common_read_file,
-	.boot		= script_boot,
+	.boot		= bootmeth_script_boot,
 };
 
 static const struct udevice_id script_bootmeth_ids[] = {
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 2a492dfd73a..e8e7396fe8a 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -425,4 +425,16 @@ int bootmeth_common_read_file(struct udevice *dev, struct bootflow *bflow,
  */
 int bootmeth_get_bootflow(struct udevice *dev, struct bootflow *bflow);
 
+/**
+ * bootmeth_script_boot() - Execute a script bootflow
+ *
+ * Set the device and partition environment variables and execute the script
+ * stored in the bootflow buffer.
+ *
+ * @dev: Bootmeth device
+ * @bflow: Bootflow containing the script image
+ * Return: 0 if OK, -ve on error
+ */
+int bootmeth_script_boot(struct udevice *dev, struct bootflow *bflow);
+
 #endif
-- 
2.43.0

