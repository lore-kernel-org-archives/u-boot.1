Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234A9C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 12:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7075586FB5;
	Mon, 18 Dec 2023 13:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="K0KrC19W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D887686F1E; Mon, 18 Dec 2023 13:02:54 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F53387142
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 13:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 346C2100003;
 Mon, 18 Dec 2023 15:02:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 346C2100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1702900971;
 bh=pbN1oHGeyh4G3+3znKX+/TjaG4zittDJJfURvfPqfPo=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:From;
 b=K0KrC19W/ADeLThDieq9MKQwkGwqZ2Uvd9Fmm8+VSIfFsJTywPU4mhqe2Uvf56tPi
 4rnL8lgwBsYy/Il2jwg56mpM6/pxDNUqkPmmW6/cXg2kMWp8hiD1z5GUdN4YyjKaD7
 d33Opc2/UdskWs47sqVTP+yDu7F3aOcvfaXGaSdPnkgMGUpCECgq4gABkNCE2uy4aX
 eXIKcKRjmkItoda7HorNzilPdUqDi86uwA5dDIIqIS5suU5XpINllybUkP85xTJF6V
 7LDppntwvupT3QTgIU2+LjUaip4ZQ92Mo74QA99H1QAIoVcHNr0XG/OvzuT+0bApEs
 OYQQwz08SHVpA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 18 Dec 2023 15:02:51 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 15:02:50 +0300
Message-ID: <f79d88f4-0d2e-1d78-065a-5a1f2f2deacf@salutedevices.com>
Date: Mon, 18 Dec 2023 14:54:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
Content-Language: en-US
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
CC: <u-boot@lists.denx.de>, <kernel@sberdevices.ru>, <oxffffaa@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jaime Liao
 <jaimeliao.tw@gmail.com>, Jaime Liao <jaimeliao@mxic.com.tw>
References: <20231130112405.92196-1-avkrasnov@salutedevices.com>
 <fa9fc4cc-892c-7c11-877b-330bf173f3bd@salutedevices.com>
In-Reply-To: <fa9fc4cc-892c-7c11-877b-330bf173f3bd@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182164 [Dec 18 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:7.1.1,5.0.1;
 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/18 06:37:00 #22676615
X-KSMG-AntiVirus-Status: Clean, skipped
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

cc: Jaime Liao

On 04.12.2023 22:23, Arseniy Krasnov wrote:
> cc: Miquel Raynal
> 
> On 30.11.2023 14:24, Arseniy Krasnov wrote:
>> Support for OTP area access on MX30LFxG18AC chip series.
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>  drivers/mtd/nand/raw/nand_macronix.c | 170 +++++++++++++++++++++++++++
>>  1 file changed, 170 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
>> index dc972e5909..4c6ddd9233 100644
>> --- a/drivers/mtd/nand/raw/nand_macronix.c
>> +++ b/drivers/mtd/nand/raw/nand_macronix.c
>> @@ -16,13 +16,183 @@
>>   * GNU General Public License for more details.
>>   */
>>  
>> +#include <dm/device_compat.h>
>>  #include <linux/mtd/rawnand.h>
>>  
>> +#define ONFI_FEATURE_ADDR_30LFXG18AC_OTP	0x90
>> +#define MACRONIX_30LFXG18AC_OTP_START_PAGE	2
>> +#define MACRONIX_30LFXG18AC_OTP_PAGES		30
>> +#define MACRONIX_30LFXG18AC_OTP_PAGE_SIZE	2112
>> +#define MACRONIX_30LFXG18AC_OTP_SIZE_BYTES	\
>> +	(MACRONIX_30LFXG18AC_OTP_PAGES *	\
>> +	 MACRONIX_30LFXG18AC_OTP_PAGE_SIZE)
>> +
>> +#define MACRONIX_30LFXG18AC_OTP_EN		BIT(0)
>> +
>> +static int macronix_30lfxg18ac_get_otp_info(struct mtd_info *mtd, size_t len,
>> +					    size_t *retlen,
>> +					    struct otp_info *buf)
>> +{
>> +	if (len < sizeof(*buf))
>> +		return -EINVAL;
>> +
>> +	/* Always report that OTP is unlocked. Reason is that this
>> +	 * type of flash chip doesn't provide way to check that OTP
>> +	 * is locked or not: subfeature parameter is implemented as
>> +	 * volatile register. Technically OTP region could be locked
>> +	 * and become readonly, but as there is no way to check it,
>> +	 * don't allow to lock it ('_lock_user_prot_reg' callback
>> +	 * always returns -EOPNOTSUPP) and thus we report that OTP
>> +	 * is unlocked.
>> +	 */
>> +	buf->locked = 0;
>> +	buf->start = 0;
>> +	buf->length = MACRONIX_30LFXG18AC_OTP_SIZE_BYTES;
>> +
>> +	*retlen = sizeof(*buf);
>> +
>> +	return 0;
>> +}
>> +
>> +static int macronix_30lfxg18ac_otp_enable(struct nand_chip *nand)
>> +{
>> +	u8 feature_buf[ONFI_SUBFEATURE_PARAM_LEN] = { 0 };
>> +	struct mtd_info *mtd;
>> +
>> +	mtd = nand_to_mtd(nand);
>> +	feature_buf[0] = MACRONIX_30LFXG18AC_OTP_EN;
>> +
>> +	return nand->onfi_set_features(mtd, nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP, feature_buf);
>> +}
>> +
>> +static int macronix_30lfxg18ac_otp_disable(struct nand_chip *nand)
>> +{
>> +	u8 feature_buf[ONFI_SUBFEATURE_PARAM_LEN] = { 0 };
>> +	struct mtd_info *mtd;
>> +
>> +	mtd = nand_to_mtd(nand);
>> +	return nand->onfi_set_features(mtd, nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP, feature_buf);
>> +}
>> +
>> +static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
>> +					loff_t offs_in_flash,
>> +					size_t len, size_t *retlen,
>> +					u_char *buf, bool write)
>> +{
>> +	struct nand_chip *nand;
>> +	size_t bytes_handled;
>> +	off_t offs_in_page;
>> +	u64 page;
>> +	int ret;
>> +
>> +	nand = mtd_to_nand(mtd);
>> +	nand->select_chip(mtd, 0);
>> +
>> +	ret = macronix_30lfxg18ac_otp_enable(nand);
>> +	if (ret)
>> +		goto out_otp;
>> +
>> +	page = offs_in_flash;
>> +	/* 'page' will be result of division. */
>> +	offs_in_page = do_div(page, MACRONIX_30LFXG18AC_OTP_PAGE_SIZE);
>> +	bytes_handled = 0;
>> +
>> +	while (bytes_handled < len &&
>> +	       page < MACRONIX_30LFXG18AC_OTP_PAGES) {
>> +		size_t bytes_to_handle;
>> +		u64 phys_page = page + MACRONIX_30LFXG18AC_OTP_START_PAGE;
>> +
>> +		bytes_to_handle = min_t(size_t, len - bytes_handled,
>> +					MACRONIX_30LFXG18AC_OTP_PAGE_SIZE -
>> +					offs_in_page);
>> +
>> +		if (write)
>> +			ret = nand_prog_page_op(nand, phys_page, offs_in_page,
>> +						&buf[bytes_handled], bytes_to_handle);
>> +		else
>> +			ret = nand_read_page_op(nand, phys_page, offs_in_page,
>> +						&buf[bytes_handled], bytes_to_handle);
>> +		if (ret)
>> +			goto out_otp;
>> +
>> +		bytes_handled += bytes_to_handle;
>> +		offs_in_page = 0;
>> +		page++;
>> +	}
>> +
>> +	*retlen = bytes_handled;
>> +
>> +out_otp:
>> +	if (ret)
>> +		dev_err(mtd->dev, "failed to perform OTP IO: %i\n", ret);
>> +
>> +	ret = macronix_30lfxg18ac_otp_disable(nand);
>> +	if (ret)
>> +		dev_err(mtd->dev, "failed to leave OTP mode after %s\n",
>> +			write ? "write" : "read");
>> +
>> +	nand->select_chip(mtd, -1);
>> +
>> +	return ret;
>> +}
>> +
>> +static int macronix_30lfxg18ac_write_otp(struct mtd_info *mtd, loff_t to,
>> +					 size_t len, size_t *rlen,
>> +					 u_char *buf)
>> +{
>> +	return __macronix_30lfxg18ac_rw_otp(mtd, to, len, rlen, (u_char *)buf,
>> +					    true);
>> +}
>> +
>> +static int macronix_30lfxg18ac_read_otp(struct mtd_info *mtd, loff_t from,
>> +					size_t len, size_t *rlen,
>> +					u_char *buf)
>> +{
>> +	return __macronix_30lfxg18ac_rw_otp(mtd, from, len, rlen, buf, false);
>> +}
>> +
>> +static int macronix_30lfxg18ac_lock_otp(struct mtd_info *mtd, loff_t from,
>> +					size_t len)
>> +{
>> +	/* See comment in 'macronix_30lfxg18ac_get_otp_info()'. */
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static void macronix_nand_setup_otp(struct nand_chip *chip)
>> +{
>> +	static const char * const supported_otp_models[] = {
>> +		"MX30LF1G18AC",
>> +		"MX30LF2G18AC",
>> +		"MX30LF4G18AC",
>> +	};
>> +	int i;
>> +
>> +	if (!chip->onfi_version ||
>> +	    !(le16_to_cpu(chip->onfi_params.opt_cmd)
>> +	      & ONFI_OPT_CMD_SET_GET_FEATURES))
>> +		return;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(supported_otp_models); i++) {
>> +		if (!strcmp(chip->onfi_params.model, supported_otp_models[i])) {
>> +			struct mtd_info *mtd;
>> +
>> +			mtd = nand_to_mtd(chip);
>> +			mtd->_get_user_prot_info = macronix_30lfxg18ac_get_otp_info;
>> +			mtd->_read_user_prot_reg = macronix_30lfxg18ac_read_otp;
>> +			mtd->_write_user_prot_reg = macronix_30lfxg18ac_write_otp;
>> +			mtd->_lock_user_prot_reg = macronix_30lfxg18ac_lock_otp;
>> +			return;
>> +		}
>> +	}
>> +}
>> +
>>  static int macronix_nand_init(struct nand_chip *chip)
>>  {
>>  	if (nand_is_slc(chip))
>>  		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
>>  
>> +	macronix_nand_setup_otp(chip);
>> +
>>  	return 0;
>>  }
>>  
