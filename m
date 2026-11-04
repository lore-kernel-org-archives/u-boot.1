Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB91606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M/dsv8bb;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ZGKE5xH+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69D5D40629;
	Wed,  4 Nov 2026 16:37:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UjjHhXpWeQBq; Wed,  4 Nov 2026 16:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 08E19403FB
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793810239;
	b=LGg84cumtw3EbIV0WZV5aW8wsoOx15uFcKiNtp+6AQK0lh94syzaQde8sd3VMSxMRqBE
	 BwT/xb6X1Q2CBO46Lsgj3ttwmiaCQ+z1WvtXeJ6y3UvlZ4NGzaK2nKAITPaTPio+byXlk
	 evfnO6KsMySR3AcmY9zNKh+BsGSLXV7fQto/nndH9uLtSaIPbTdaXYmMPI8d0v42gASha
	 966g3z6AaDmxJ7DcZpgJ+DkDKNUP8Gh1Uz+wAXautV3VFPf8ahxHy03uwW2yZWQMBXFKp
	 gSxJyxBXDiVLXFMef/g7J16/GIvyE4ooQ9na72ZAOjC3KWbwAP0eJcKkp1u4+RxEIZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Lbx3SPgiCBe1gYyMJZ15E3Nia84IK64Ed7NKtHF+4K0=;
	b=sfvBepXmvz9eO5JsWdYOTgfNw6t99XBWVDtUtbA+eZ6mVUAbgZkk2Mo1J7kCRfX3m/is
	 YLzKqlWEOYxMWCyGCfExkQol0qUrrdurtoWSXRCNDE53gne+tnxDKOqqHYIBQXmjPTX0J
	 rNE8HiOgHgUxzLAcT9TPUwWu6W8Nxcbkd5otjgLLKdaaUytE/OEXM9J1WjWFZHFqd6U4w
	 NVSVcGPmsFXDsz1zIeBGGlcJcDOsLSOniIu6zJHz95igSxIcuBSzW8zrS3WGKQm/qEzMx
	 MhVRDgIjxwsAUKiyjRf6UPZgZSQe3yPZPkiswACrYZM18C75YDGIonxr4mn34buYuxA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810239;
	bh=Lbx3SPgiCBe1gYyMJZ15E3Nia84IK64Ed7NKtHF+4K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M/dsv8bbTCOWVCCTnfSQEPjZaXgqokij2LGE4OyMBcSStn3Yhj6vwxQc3/f9fj7Rh
	 uNxa/TjQgKMT2YhrkItG6UdLesVzRlQHdmMo0tN3rJRIPFi05eZ5Q5SJVqCS4dhU1/
	 mnMq01c0eRXWeYcyYVBm+GcttPJ4F06g3YKw8Di6LmDyq6nLGYhiwTMRGBHhpS751K
	 Fr8kSkVPOH9IZFAh+BfIrEhQ1iFepZYizbKCjMiTJUgWW/nTdWDBaDumWiTy1VzES+
	 GXtP0lEaFFmXjQYug/zYkewvaszfYXyrIbZvioH89qwFa3+E/Pc190MiMrBeAnwXhE
	 8lcT4s955Kisw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08E19403FB;
	Wed,  4 Nov 2026 16:37:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92CF8341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 788B060628
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z0pM_wK_FLKG for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 14:11:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C6656062C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793801499;
 b=IAesQbLTxkZ8MQmWCpgiR9xjq0BsiUl6FntssETEAWXfPxAkdZbwBSuA9PpCv/TbeLpY
 XJ5zJbTIUAk6c4gL4Gbm0nw1ibO3j40e5FrCzTNtsNQIIMrXqcXl5I0LAQBUvnKIKbAZP
 F81HEXD2682XsS0NHf/wuiZBLjg7Nludu0b9AXc/YpoGCJPgqp6Kr9+RFONuU0qghxOc1
 /FAPi2rSpLFK+YdKbeaF/0dH+XhRuFrW7zFdREq7EAsV67IhfCg+5mCkj7VbQvgIPQIGm
 /kcfKVol+IfN71oeuBWbp63P8w/Usvu9XjezHnN36/FD3q2GTmCVp4cU0E6gD86cgQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793801499;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
 X-Virus-Status;
 bh=Lbx3SPgiCBe1gYyMJZ15E3Nia84IK64Ed7NKtHF+4K0=;
 b=PCcMPyuNTbGrkY+VBKbzRnq3QhuJoHLxMJAnnEsBlZXciLHGLQYnbJMx7bvmbc9Bpl73
 0ygAyoApvp3ZFtbSZJMOxb+Lg0jj/N8jDwy6057m9RA7Utv4m8XTRfCRvnW44XeByiFBI
 vWkC+xAwR8K2nUrPGTwozli4+gh7MpaQSHpZzmGdIMqynHLtDeF/jYh3PnryhdkPhXFZR
 g6lMjOmwlz2so7wdjWFoe5KKLyVouQONf/1I8OkNOWt/HGN2UyO7HlL7pmOIdJcirS/5W
 3F0MbqNEXe8TcqIuFU3fYqhqmPsv49eXzhYKUceg3YyJFozpD+excEDPwTbznA758Ow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=qq.com;
 spf=fail smtp.mailfrom=qq.com;
 dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=ZGKE5xH+; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=xjmps7114@qq.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=qq.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256
 header.s=s201512 header.b=ZGKE5xH+
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C6656062C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:11:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205678482B; Wed,  4 Nov 2026 15:11:31 +0100 (CET)
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com
 [162.62.57.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE65483E76
 for <u-boot@lists.denx.de>; Wed,  4 Nov 2026 15:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=xjmps7114@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1793801479; bh=Lbx3SPgiCBe1gYyMJZ15E3Nia84IK64Ed7NKtHF+4K0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZGKE5xH+GI7dcGGJFCaN7i/hlR0KqLJHW4J9sIlTX++ckAgrrjZbJj3DvZIsOKktO
 FujL9VjkM5UVZzPKQHgz3ufkK70zO9F9ueQ11ARLuT15z97VaBn8V3rkRdsaJpyn8Q
 xwErAdTjZzw2NQBNR/Eu7blwV9k9l2phgihgSRVU=
Received: from localhost.localdomain ([27.38.1.195])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 2D030261; Wed, 04 Nov 2026 22:11:16 +0800
X-QQ-mid: xmsmtpt1793801477tvwu5jk9k
Message-ID: <tencent_2570A614E7B8955F61CA5DE0070B17874006@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeQR3kqq5V3U2FWQ+lSXPz5/gExKfxbgKtyFxXh65gTsJpWoMCL6
 ADGgpXou6n8bNOzG5anAR9FmYHYItZuea4EFQc+gtOXbxcsPG8ZwWhg4MBzhSMmasXyx86WgO9Uz
 bi3RK7649uitfMEnXUk1dRLDHAnTYojMUY24W4qAe7wlMmQgC64fPxBSqQRns3ohl9RLRRWbDugo
 O3M40ubw47uUhylY/FvokbtozUK118KqnYaELFa65ysx1B1ZTMY29BRICUeXnWwgCgTLMDSpDaH/
 sQorc6DkpjFy1NVgiLYu3ctzWD+mUfH5ydIA8XySDq2n2oMLmoji2XnHUCOC7n8UGmSXR3IgtB4E
 oYxOX27NqD8WMgrFQpQQSRt+cgBpsGgK5fUrwb2zeVVg1SjNh6IenCgRrBiikEMxGIK/fcNy6PYB
 eLWuQffkzo+AbXydqDJ3eab6VKCNwPTar9sKJU+g70ZqlYo683vCv1z/DSaPPlnskLiuBJ77Z0Cf
 TK20dK1rOYEStTllAarjRAlsDZqY3A49WT0B6QseByAM6mXHo0zLtTuppxfdmCqm1Rs8fFfxVdQb
 DirNaiPq8dVjusUDi5UO7bxNmxiS7yTCUYbUvLrSHeq+FVOIhjnr+c6uaCPNyZDOxgkRUAigkh/5
 5FRtbE5AG2M5AsZPoEr7LfnFIhkGUp+ALCEO8LOlNG8j2a0GPZeVUbeuv+qAtHLLytM0jHkF+eH5
 iagWNwEYZeHiZXSl2HbHGZvI+WC47kHJy6w/bclFwL/WwJuwwnq6+Hlo5tPpxPHbM951tNi+sMse
 OFoOwzmR564U+Tkc8x3nhgtLxwh/j+Ti2TZ25rdOpnOswqmxOre+/ODMBI4I+vJCs400mFebBcpK
 CBdclAhal6NXGI0tIzaDqJyrJMOm/7AcghbcGl00pJowffbykhIRP8oxY/m/fTI+VMMhdtVTxZXJ
 axTONh8MKUO/cvn+/P3hZPzDGZkeZDXXeM2wYDsQ9WClc87s/D9uQojxhbT9XafCLspk1OSgq8RJ
 r4BegpgyZCpfm8d9Tk8uHSmhRsDkE7ABjeX3Tk/ESbLTIH8T88O8ohWxOWhBY=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: eli <xjmps7114@qq.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	xjmps7114@qq.com
Subject: [PATCH 2/2] doc: spl: describe SPL FIT anti-rollback usage
Date: Wed,  4 Nov 2026 22:11:17 +0800
X-OQ-MSGID: <20261104141117.12284-3-xjmps7114@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104141117.12284-1-xjmps7114@qq.com>
References: <20261104141117.12284-1-xjmps7114@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 04 Nov 2026 16:37:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document CONFIG_SPL_MINIMUM_FIT_VERSION, the FIT configuration 'version'
property it checks, and the trust-root boundary of the mechanism (the
minimum lives in the SPL binary itself).

Signed-off-by: eli <xjmps7114@qq.com>
---
 doc/develop/spl.rst | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index 08b51172..762edeea 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -125,6 +125,49 @@ Use `xpl_phase()` to find the current U-Boot phase, e.g. `PHASE_SPL`. You can
 also find the previous and next phase and get the phase name.
 
 
+SPL FIT anti-rollback
+---------------------
+
+When SPL verifies a signed FIT (CONFIG_SPL_FIT_SIGNATURE), the signature
+guarantees that the image is authentic, but not that it is current: an
+attacker who can write the next-stage image location could replace it with an
+older image that is still correctly signed, reintroducing vulnerabilities
+fixed in newer firmware.
+
+CONFIG_SPL_MINIMUM_FIT_VERSION adds a software rollback check: after
+signature verification succeeds, SPL reads the "version" property of the
+selected configuration node and refuses to boot if it is lower than this
+value. A missing property counts as version 0, so the minimum must be raised
+together with images that actually carry the property. The default of 0
+disables the check.
+
+Example configuration node::
+
+    configurations {
+        default = "conf-1";
+        conf-1 {
+            version = <0x2>;
+            description = "U-Boot 2026.07";
+            firmware = "uboot";
+            signature-1 {
+                algo = "sha256,rsa4096";
+                key-name-hint = "dev";
+                sign-images = "firmware";
+            };
+        };
+    };
+
+The configuration node, including its "version" property, is covered by its
+signature, so the property cannot be forged without the signing key; the
+minimum version itself is fixed at SPL build time.
+
+Note that this is a software trust root: the minimum version lives in the SPL
+binary, so an attacker able to rewrite the SPL itself (for example via a
+writable boot flash) can also lower the minimum. For a stronger guarantee,
+protect the SPL boot medium against writes or anchor the trust root in
+one-time programmable storage.
+
+
 .. _fdtgrep_filter:
 
 Device tree
-- 
2.53.0

