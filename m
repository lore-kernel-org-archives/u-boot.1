Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405C7C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 03:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4596587702;
	Fri,  5 Jan 2024 04:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uvhcOpv7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 517D987702; Fri,  5 Jan 2024 04:41:13 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF91876C4
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 04:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4053ewK8088116;
 Thu, 4 Jan 2024 21:40:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704426058;
 bh=Ua0RSaTLn6PPmJv/LfXU1lRY1ASIZ2Zk68UZLcbrJNM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=uvhcOpv7VfdodmktNF/XjDJHJ3XDaFtAVOSyN1ufcjbPgdz+ZBTootxYVfBBPUuA/
 NxIJ07OmiyP9edQxMVZbzJJq86L4EpkNxO0gIDpWvQ3m8v3PBo5umIgafwiJfhu1Pn
 NxvvPhMUObHgqtH3kckphvMmc75iWzBlpB1OvymI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4053ewh9118478
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jan 2024 21:40:58 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 21:40:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 21:40:58 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4053esTc102376;
 Thu, 4 Jan 2024 21:40:54 -0600
Message-ID: <a96db127-5880-42b1-8736-518356696314@ti.com>
Date: Fri, 5 Jan 2024 09:10:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tools: binman: ti_board_cfg: Check for linting
 problems
To: Nishanth Menon <nm@ti.com>
CC: <sjg@chromium.org>, <vigneshr@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>,
 <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>, <vishalm@ti.com>,
 <jonas@kwiboo.se>, <sughosh.ganu@linaro.org>,
 <lukas.funke@weidmueller.com>, <fr0st61te@gmail.com>, <u-kumar1@ti.com>
References: <20240104075357.638983-1-n-francis@ti.com>
 <20240104075357.638983-3-n-francis@ti.com>
 <20240104152140.hn5rblwcngunir3g@comply>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240104152140.hn5rblwcngunir3g@comply>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Nishanth

On 04/01/24 20:51, Nishanth Menon wrote:
> On 13:23-20240104, Neha Malcom Francis wrote:
>> Use yamllint for checking whether YAML configuration files are adhering
>> to default yamllint rules.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> Suggested-by: Nishanth Menon <nm@ti.com>
>> ---
>>   tools/binman/etype/ti_board_config.py        |  5 +++++
>>   tools/binman/ftest.py                        |  6 ++++++
>>   tools/binman/test/323_ti_board_cfg_phony.dts | 14 ++++++++++++++
>>   tools/binman/test/yaml/config.yaml           |  4 ++--
>>   tools/binman/test/yaml/config_phony.yaml     | 18 ++++++++++++++++++
>>   5 files changed, 45 insertions(+), 2 deletions(-)
>>   create mode 100644 tools/binman/test/323_ti_board_cfg_phony.dts
>>   create mode 100644 tools/binman/test/yaml/config_phony.yaml
>>
>> diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
>> index 94f894c281..2c3bb8f7b5 100644
>> --- a/tools/binman/etype/ti_board_config.py
>> +++ b/tools/binman/etype/ti_board_config.py
>> @@ -9,6 +9,7 @@
>>   import os
>>   import struct
>>   import yaml
>> +import yamllint
> 
> Don't you need to add this to requirements.txt?
> 

Yes I do... thanks for catching that!

>>   
>>   from collections import OrderedDict
>>   from jsonschema import validate
>> @@ -18,6 +19,7 @@ from binman.entry import Entry
>>   from binman.etype.section import Entry_section
>>   from dtoc import fdt_util
>>   from u_boot_pylib import tools
>> +from yamllint import config
>>   
>>   BOARDCFG = 0xB
>>   BOARDCFG_SEC = 0xD
>> @@ -244,6 +246,9 @@ class Entry_ti_board_config(Entry_section):
>>               with open(self._schema_file, 'r') as sch:
>>                   self.schema_yaml = yaml.safe_load(sch)
>>   
>> +            yaml_config = config.YamlLintConfig("extends: default")
>> +            for p in yamllint.linter.run(open(self._config_file, "r"), yaml_config):
>> +                self.Raise(f"Yamllint error: {p.line}: {p.rule}")
>>               try:
>>                   validate(self.file_yaml, self.schema_yaml)
>>               except Exception as e:
>> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
>> index a4ac520cbb..1fbb0fef1a 100644
>> --- a/tools/binman/ftest.py
>> +++ b/tools/binman/ftest.py
>> @@ -7030,6 +7030,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>>           data = self._DoReadFile('293_ti_board_cfg.dts')
>>           self.assertEqual(TI_BOARD_CONFIG_DATA, data)
>>   
>> +    def testTIBoardConfigLint(self):
>> +        """Test that an incorrectly linted config file would generate error"""
>> +        with self.assertRaises(ValueError) as e:
>> +            data = self._DoReadFile('323_ti_board_cfg_phony.dts')
>> +        self.assertIn("Yamllint error", str(e.exception))
>> +
>>       def testTIBoardConfigCombined(self):
>>           """Test that a schema validated combined board config file can be generated"""
>>           data = self._DoReadFile('294_ti_board_cfg_combined.dts')
>> diff --git a/tools/binman/test/323_ti_board_cfg_phony.dts b/tools/binman/test/323_ti_board_cfg_phony.dts
>> new file mode 100644
>> index 0000000000..441296de4f
>> --- /dev/null
>> +++ b/tools/binman/test/323_ti_board_cfg_phony.dts
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/dts-v1/;
>> +
>> +/ {
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +
>> +	binman {
>> +		ti-board-config {
>> +			config = "yaml/config_phony.yaml";
>> +			schema = "yaml/schema.yaml";
>> +		};
>> +	};
>> +};
>> diff --git a/tools/binman/test/yaml/config.yaml b/tools/binman/test/yaml/config.yaml
>> index 5f799a6e3a..c2be32128b 100644
>> --- a/tools/binman/test/yaml/config.yaml
>> +++ b/tools/binman/test/yaml/config.yaml
>> @@ -10,9 +10,9 @@ main-branch:
>>       b: 0
>>     arr: [0, 0, 0, 0]
>>     another-arr:
>> -    - #1
>> +    -  # 1
>>         c: 0
>>         d: 0
>> -    - #2
>> +    -  # 2
>>         c: 0
>>         d: 0
>> diff --git a/tools/binman/test/yaml/config_phony.yaml b/tools/binman/test/yaml/config_phony.yaml
>> new file mode 100644
>> index 0000000000..d76fcb3b82
>> --- /dev/null
>> +++ b/tools/binman/test/yaml/config_phony.yaml
>> @@ -0,0 +1,18 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +#
>> +# Test config
>> +#
>> +---
>> +
>> +main-branch :
>> +  obj :
>> +    a : 0x0
>> +    b: 0
>> +  arr: [0, 0, 0, 0]
>> +  another-arr:
>> +    -  # 1
>> +      c: 0
>> +      d: 0
>> +    -  # 2
>> +      c: 0
>> +      d: 0
>> -- 
>> 2.34.1
>>
> 

-- 
Thanking You
Neha Malcom Francis
