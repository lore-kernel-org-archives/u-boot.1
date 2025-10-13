Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052AFCCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 21:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D4583710;
	Mon, 13 Oct 2025 23:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="m4yMZAPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5E1839CA; Mon, 13 Oct 2025 20:36:52 +0200 (CEST)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E487D838D7
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 20:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-50ddbb-117.dhcp.inet.fi
 [80.221.187.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4clmKB1DhJzyQf
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 21:36:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1760380606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OAtp/ruVpHxtlYByU1kn5tD3QhXLrd242rqCs5nPIHw=;
 b=m4yMZAPm6QvZF74EEtnZ0lpt0DjPOTRQV1hPJn2AMF0xziaqeoASpqe2ojnH5ykJgxmZv7
 tMKVcuG1TQl2OwNjbPL6jNuSkpH9HmXDnGXnbCZdeXzXFJ5N0963fBimWO5CmtSATNm4Nl
 upcosCTikY5Vruk+tVgeFJCiU1jRGKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1760380606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OAtp/ruVpHxtlYByU1kn5tD3QhXLrd242rqCs5nPIHw=;
 b=ojnubeRejA92KkFcWoOYaKtcxCeLnPj/GCvifYo17p8zHigrsM+XX630eh6zRAp4XLtWyD
 QbV6AUO+tSSlHwYoBtzdxZ3epc58iB7EUVS05ZDVqvlbhMdWOcE72K9nnmIyU3CSdr1HNS
 fJyAKutsALTKHgD3r+cJurpGcyNWFzA=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1760380606; a=rsa-sha256; cv=none;
 b=eSthRDKYJs+5kZzLZBNVot/i9Ht3jiSKeg6kdDvAvJSxGKx817SkJmO3GK7PgTM+Slh3MO
 VenQmWNZc1r3ZBuAdY04DaNKIy/0yLuuyJgA7xZGnJrrN0tgFi0eaq2aE378vPTXBJGl0o
 WmRfFv/rx/udXuQaXHjDfTB6AQ6WyKs=
Date: Mon, 13 Oct 2025 21:36:44 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: u-boot@lists.denx.de
Subject: How to use ECDSA for signature verification?
Message-ID: <aO1GvGrXUw-co84_@kehys.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Oct 2025 23:07:58 +0200
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

Hi all,

Yesterday, I successfully built the u-boot master branch with 
CONFIG_FIT_SIGNATURE=y and CONFIG_RSA=y and got the signature 
verification working with sha256,rsa2048.

Today, I wanted to try out CONFIG_ECDSA=y, but I am facing some trouble.  
I am generating the key and trying to add its public part to the device 
tree blob as with fdt_add_pubkey as follows:

openssl ecparam -name secp521r1 -genkey -noout -out dev-private.pem
openssl ec -in dev-private.pem -pubout -out dev.pem
cd u-boot
make ...
cp u-boot.dtb u-pubkey.dtb
tools/fdt_add_pubkey -a sha512,secp521r1 -n dev -k .. -r conf u-pubkey.dtb

The next step would be to run make EXT_DTB=u-pubkey.dtb ... so that the 
public key will be embedded and the signature verification will be 
enabled in the final u-boot.img.

Alas, the fdt_add_pubkey command would crash in SIGSEGV in alloc_ctx().  
I figured out that the hash algorithm is not being looked up and 
assigned. Maybe this is not necessary for the -a sha256,rsa2048 which I 
was successfully using previously. The following patch fixes the 
SIGSEGV:

diff --git a/tools/fdt_add_pubkey.c b/tools/fdt_add_pubkey.c
index 5582d7a8efe..4f7028cc15c 100644
--- a/tools/fdt_add_pubkey.c
+++ b/tools/fdt_add_pubkey.c
@@ -73,9 +73,10 @@ static void reset_info(struct image_sign_info *info)
  	info->keyname = keyname;
  	info->name = algo_name;
  	info->require_keys = require_keys;
+	info->checksum = image_get_checksum_algo(algo_name);
  	info->crypto = image_get_crypto_algo(algo_name);
  
-	if (!info->crypto) {
+	if (!info->checksum || !info->crypto) {
  		fprintf(stderr, "Unsupported signature algorithm '%s'\n",
  			algo_name);
  		exit(EXIT_FAILURE);

However, with the above patch applied, I am facing the next trouble:
tools/fdt_add_pubkey -a sha512,secp521r1 -n dev -k .. -r conf u-boot-key.dtb
Can not read key from '../dev.pem'
tools/fdt_add_pubkey: Cannot add public key to FIT blob: Unknown error -5

In GDB, I can see that read_key() in lib/ecdsa/ecdsa-libcrypto.c would 
invoke PEM_read_PrivateKey(), which I assume will fail, because 
../dev.pem only contains a public key. In the planned deployment, the 
private key would be private to a HSM or an external service. Moreover, 
I do not understand why fdt_add_pubkey would attempt to access a private 
key in the first place; that should only be needed for signing the 
fitImage. Both prepare_ctx() and ecdsa_add_verify_data() would return 
-5, which main() is reporting to stderr.

Has some way of using ECDSA based signature verification been tested?  
The reason why I would like to avoid RSA is that it is not thought to be 
quantum-secure, or secure against a cryptalalytic attack by a quantum 
computer.

With best regards,

	Marko Mäkelä
