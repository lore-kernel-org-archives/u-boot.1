Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F3CC369C2
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 01:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E42828BC;
	Sat, 26 Apr 2025 03:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58C8982918; Sat, 26 Apr 2025 03:13:44 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEBD5828B3
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 03:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.61.227])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 843DAB2212AC;
 Sat, 26 Apr 2025 03:13:40 +0200 (CEST)
Message-ID: <756019b8-60f6-4cab-92b0-cd1e857a375c@freeshell.de>
Date: Fri, 25 Apr 2025 18:13:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] u-boot-riscv/master
To: Tom Rini <trini@konsulko.com>, Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
References: <aAte-nS8ZhO_Odw1@swlinux02>
 <174562459055.746741.13011026537921584133.b4-ty@konsulko.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <174562459055.746741.13011026537921584133.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The outcome of that merge went a bit weird for
board/starfive/visionfive2/spl.c

On 4/25/25 16:43, Tom Rini wrote:
> On Fri, 25 Apr 2025 18:07:54 +0800, Leo Liang wrote:
> 
>> The following changes since commit 10f48365112b164bee6564033ab682747efcb483:
>>
>>   Merge patch series "Add PCIe support for TI AM64 SoC" (2025-04-24 10:46:17 -0600)
>>
>> are available in the Git repository at:
>>
>>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
>>
>> [...]
> 
> Merged into u-boot/master, thanks!
> 

# The fix:

diff --git a/board/starfive/visionfive2/spl.c
b/board/starfive/visionfive2/spl.c
index 353313b9e88..5b9f2530470 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -116,44 +116,23 @@ void board_init_f(ulong dummy)
 #if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	const char *product_id;
-	u8 version;
-
-	product_id = get_product_id_from_eeprom();
-
-	/* Strip off prefix */
-	if (strncmp(name, "starfive/", 9))
-		return -EINVAL;
-	name += 9;
-	if (!strncmp(product_id, "FML13V01", 8) &&
-	    !strcmp(name, "jh7110-deepcomputing-fml13v01")) {
-		return 0;
-	} else if (!strncmp(product_id, "VF7110", 6)) {
-		version = get_pcb_revision_from_eeprom();
-		if ((version == 'b' || version == 'B') &&
-		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
-			return 0;
-
-		if ((version == 'a' || version == 'A') &&
-		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.2a"))
-			return 0;
-	} else if (!strncmp(product_id, "MARS", 4) &&
-		   !strcmp(name, "jh7110-milkv-mars")) {
+	if (!strcmp(name, "starfive/jh7110-deepcomputing-fml13v01") &&
+		    !strncmp(get_product_id_from_eeprom(), "FML13V01", 8)) {
 		return 0;
 	} else if (!strcmp(name, "starfive/jh7110-milkv-mars") &&
-		   !strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
+		    !strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
 		return 0;
-	} else if ((!strcmp(name, "starfive/jh7110-pine64-star64")) &&
+	} else if (!strcmp(name, "starfive/jh7110-pine64-star64") &&
 		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
 		return 0;
-	} else if ((!strcmp(name,
"starfive/jh7110-starfive-visionfive-2-v1.2a")) &&
+	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2a") &&
 		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
 		switch (get_pcb_revision_from_eeprom()) {
 		case 'a':
 		case 'A':
 			return 0;
 		}
-	} else if ((!strcmp(name,
"starfive/jh7110-starfive-visionfive-2-v1.2b")) &&
+	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2b") &&
 		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
 		switch (get_pcb_revision_from_eeprom()) {
 		case 'b':


# So when applied that function should end up like this:

#if CONFIG_IS_ENABLED(LOAD_FIT)
int board_fit_config_name_match(const char *name)
{
	if (!strcmp(name, "starfive/jh7110-deepcomputing-fml13v01") &&
		    !strncmp(get_product_id_from_eeprom(), "FML13V01", 8)) {
		return 0;
	} else if (!strcmp(name, "starfive/jh7110-milkv-mars") &&
		    !strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
		return 0;
	} else if (!strcmp(name, "starfive/jh7110-pine64-star64") &&
		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
		return 0;
	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2a") &&
		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
		switch (get_pcb_revision_from_eeprom()) {
		case 'a':
		case 'A':
			return 0;
		}
	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2b") &&
		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
		switch (get_pcb_revision_from_eeprom()) {
		case 'b':
		case 'B':
			return 0;
		}
	}

	return -EINVAL;
}
#endif

