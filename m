Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD98CCFA13
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 17:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CB8783D2E;
	Sat,  8 Nov 2025 18:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="GKMVJ9l1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 920E783E23; Sat,  8 Nov 2025 18:24:08 +0100 (CET)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 534CD83B03
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 18:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4d3jTF3ynyz49Py8
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 19:24:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1762622641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QjU+ppVUk8tXKyE1slYXffrQSCS6v82yM9oAsPojDJs=;
 b=GKMVJ9l1TV7Jw6hnhPJv9D1lTd/Jq0xkXR0X3kNNypBQimH6q5rLUJ9tY3rUWdlK4DkQpM
 D5lhFJpOeUBR/7w2ujtU2J7t68WD2nJDP/cPv4dge7lasGep+5dYMVmLhKpavq9T4grzG+
 tmHPgCyarq6+jMf0BLSKQ4Zseq4Yt9xDDec28uggJzY70auEA1oQHkp/hGJqjFvsPppCj5
 0WgK+YWiyB7J8SZOmesr9ULprb0xa7d0BaJRQR1nrETpqb4im3OB4e6qf/1pLMzHy/spLf
 739Qdz3HfNIUqmRFz4A/nzvjv0r/uRC88eTkNmWJ3vhn8rB1ObjF/jcOFcPUJA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1762622641; a=rsa-sha256; cv=none;
 b=ncA4zw35YEv0JU8Ff7xHVEiE25drtsx/+/+UsaqNkorpmYs9xoOn2u8dqKVQ0rtmWzEmC6
 MI69haINIMddC8qb2/S7DMzZ83EZvG+UP7YE5nlgMbc6AXWox670ufKQHkp18IKuxLCYnb
 mcTM9xB0ZNloJG7mAMBa8PRt0frmey54PII5/To4IFPyJSpkpB2ypRVgq1uXaOKu/kC7hd
 yts5/I9st3C2xf+rDTdnOtwHba9IWcCcJ+XCsdmbr0bV2PXzjry6P5wfgBaOPVXlv5PL1S
 DP/wZZfFhV/m34lZ2Cxch8UBMiwxul7bF+fAU+xTi3XjetIEu4VbPVGuT1q6Rg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1762622641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QjU+ppVUk8tXKyE1slYXffrQSCS6v82yM9oAsPojDJs=;
 b=haSVYUQ/Ic5+RCl73QT+ivaIwKJJjib3sqj4lYRYTIq5r5LWK48T9QvBZQpih1AAp1ZmX8
 xFNY/kDTe07N2PzZ1rdFK7oXH24d15TniJea8gCFsuA0cZaVJ/3gqKMuLKvbFuM88jlyAa
 EwxskMOSceIiDRK7TSdkcNumBqETQQtO5UTQT4BuyTpOgrcyRHdmcgLAUwlUbmRSWi75dP
 WqjveQBr7HY3aAmromhXiOFrXP7V65nEOBmdiPe3vB5sVcGVGLjwz236/XGCLt6jvGbwrx
 ju7s2gpcyQtKAfA0KVgCqu9TTMihSwUncgyiGrSFEt/St39n9Q9kT/5vcUqoUQ==
Date: Sat, 8 Nov 2025 19:24:00 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: u-boot@lists.denx.de
Subject: Re: How to use ECDSA for signature verification?
Message-ID: <aQ98sHenb3G1MQDi@kehys.lan>
References: <aO1GvGrXUw-co84_@kehys.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aO1GvGrXUw-co84_@kehys.lan>
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

I am new to u-boot, please bear with me. I got CONFIG_FIT_SIGNATURE=y to 
work with the RSA algorithm, but not with ECDSA.

My two main questions are:

Is CONFIG_ECDSA_VERIFY only implemented for the two targets:
rom_api_ops in arch/arm/mach-stm32mp/ecdsa_romapi.c
cptra_ecdsa_ops in drivers/crypto/aspeed/cptra_ecdsa.c. 

Is it feasible to support something more modern than RSA signatures on a 
reasonably high-end target, such as ARMv8? Are there any suggestions or 
git commits that you would suggest as a reference?

Mon, Oct 13, 2025 at 09:36:50PM +0300, Marko Mäkelä wrote:
>Hi all,
>
>Yesterday, I successfully built the u-boot master branch with 
>CONFIG_FIT_SIGNATURE=y and CONFIG_RSA=y and got the signature 
>verification working with sha256,rsa2048.
>
>Today, I wanted to try out CONFIG_ECDSA=y, but I am facing some 
>trouble.  I am generating the key and trying to add its public part to 
>the device tree blob as with fdt_add_pubkey as follows:

I got a bit further with this, using the algorithm sha256,ecdsa256.

With a patch and some work-arounds, I think I understood the host-side 
workflow. However, the signature check on my target (TI Sitara am62x) is 
failing.

Unlike with RSA, the mkimage command expects the ECDSA private key in a 
file like dev.pem, not dev.key. I successfully created a private key and 
constructed a signed FIT image with the following commands:

openssl ecparam -name prime256v1 -genkey -noout -out dev.pem
mkimage -k . -f fitImage.its fitImage

I verified the presence of a signature by running the following command, 
which produced the signature in a "value" subnode:

dtc -I dtb fitImage|grep -A10 signature

For the algorithm sha256,ecdsa256 that I chose, the fdt_add_pubkey tool 
requires a patch to avoid SIGSEGV, which I am copying below from my 
previous message:

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

Unlike with RSA, fdt_add_pubkey does not accept a public key:

fdt_add_pubkey: Cannot add public key to FIT blob: Unknown error -5

I am able to work around this by invoking the tool on a _private_ key 
dev.pem that the fitImage had been signed with.

I don't know if there is a cleaner way, but here's how I am embedding 
the public key to the image. I first build U-boot from the scratch, 
modify the generated u-boot.dtb, and finally rebuild to have the 
modified DTB included:

make clean
make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu- ...
cp u-boot.dtb u-boot-pubkey.dtb
fdt_add_pubkey -a sha256,ecdsa256 -n dev -k . -r conf u-boot-pubkey.dtb
fit_check_sign -f fitImage -k u-boot-pubkey.dtb
make EXT_DTB=u-boot-pubkey.dtb \
-j$(nproc) CROSS_COMPILE=aarch64-linux-gnu- ...

Even though fit_check_sign passes on the host system, the signature 
check would fail on the target system (TI AM62x) as follows:

8304957 bytes read in 346 ms (22.9 MiB/s)
## Executing script at 90000000
sha256,ecdsa256:dev-  error!
Unknown signature algorithm for '<NULL>' hash node in 'conf-1' config node
Failed to verify required signature 'dev'
Boot failed (err=1)

It turns out that for ECDSA signature verification, at least three 
configuration options will be needed:

CONFIG_FIT_SIGNATURE=y
CONFIG_ECDSA=y
CONFIG_ECDSA_VERIFY=y

Rebuilding with CONFIG_ECDSA_VERIFY=y changed the error message to the 
following:

sha256,ecdsa256:dev-  error!
Verification failed for '<NULL>' hash node in 'conf-1' config node
Failed to verify required signature 'dev'

I did not attach a debugger to the target, but I am rather sure that the 
verification fails because of the following:

static int ecdsa_verify_hash(struct udevice *dev,
			     const struct image_sign_info *info,
			     const void *hash, const void *sig, uint sig_len)
{
	const struct ecdsa_ops *ops = device_get_ops(dev);
	const struct checksum_algo *algo = info->checksum;
	struct ecdsa_public_key key;
	int sig_node, key_node, ret;

	if (!ops || !ops->verify)
		return -ENODEV;

I found only two definitions of ecdsa_ops, and it does not look like 
either one should be available on my target system.

The cosmetic error <NULL> in the error message occurs because the local 
variable "noffset" in fit_image_verify_sig() will only be valid if the 
for loop is executing "goto error". This bug is tricky to fix, because 
as far as I understand, we want to allow multiple signatures to be 
verified.

One more thing that I noticed is that the function fit_check_sign() has 
an unused parameter:

diff --git a/tools/fit_check_sign.c b/tools/fit_check_sign.c
index ab3266aff20..3d1e66f2b58 100644
--- a/tools/fit_check_sign.c
+++ b/tools/fit_check_sign.c
@@ -80,7 +80,7 @@ int main(int argc, char **argv)
  			return EXIT_FAILURE;
  	}
  	image_set_host_blob(key_blob);
-	ret = fit_check_sign(fit_blob, key_blob, config_name);
+	ret = fit_check_sign(fit_blob, NULL, config_name);
  	if (!ret) {
  		ret = EXIT_SUCCESS;
  		fprintf(stderr, "Signature check OK\n");

The above patch shows the only caller of the function. It also shows 
that the caller is invoking image_set_host_blob() on that parameter, 
which is why the check is able to work. Maybe that call should be made 
part of fit_check_sign() itself? Anyway, this code does not execute on 
the target.

With best regards,

	Marko Mäkelä
