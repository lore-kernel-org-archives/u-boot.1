Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A4AC4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 12:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEEAD87B13;
	Mon, 22 Jan 2024 13:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cMTCgHrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BF848796E; Mon, 22 Jan 2024 13:59:43 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23BB687B13
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 13:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e775695c6so31290025e9.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 04:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705928380; x=1706533180; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F3hLV3PDIzmevMRBNFMTCCB8CcaIRooJxlsmG1nan6I=;
 b=cMTCgHrlLhNFLKweqLQR00xLSZsBqWGl7Ne9gmWRtRIQffA622ZPe/YEa4ipTDBXyM
 tOQBLb2gSkpIIxele8+/eGmk9skyyIsze7teAf1c0qREqgMCfrYsfO69+LCtOA+0epnc
 pX2ettiYqhrDyDbsaseY8Dt9MHVbjSS8WYPgtXtvayuCZHMjiYkQkqGvjBY3W2V8T64H
 55UQj8qHgD2htg+3h7lJXUeXiPmopYeR9kcJs9rGA66dSalfOu5sXjYZVBLZZsX8Xdn0
 cQeVIgR/4Gjw8et7G6ZQH0aflI5MeoabDrf5QsvGcnH+MxlFTNFjqflwio8rtBZT2fo+
 WP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928380; x=1706533180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3hLV3PDIzmevMRBNFMTCCB8CcaIRooJxlsmG1nan6I=;
 b=GilBwpleWeQOcrGc8Z+hxdVsRiWvx+Lz5WUC+IDJmKetkaV1MhPQ1yHRSSoT7C9eWd
 B2mrhVzqelCbM6QRn9gw/giXwfS1hULT0HJcYYUoembsCl55dCDZZ2APVXh0RRjPIJqf
 acDpEZdYMd9eqrKknUHcIgQa1keCY9cTNIIJG0PZ0T+cXhzmG5sHvX7r0RABGR6F2J0J
 A0ckXj54JCwW+hWSr9zaUbY98Z7/efWdxKl0xbqYUUkcX4y2xOY/kJstDsf7fw6sSrVc
 a9FF6Fjt1H0+p1voFlRRUcZ4MoLlMMpUwN0WXqMSalXcMwU7Z/Ab4iEcGryGMZjjv3Te
 eHZA==
X-Gm-Message-State: AOJu0YxWEXM4UMsL9fZIruQkQN5LUFH/ZQWU2t68vrxXYhXSNvXyD1D5
 I9CwGdHQaJZvfrU+Tk6NzDJdZ+BAIvcwFeBzWDkiqmMsK0gr+psMP+Wpc/rn
X-Google-Smtp-Source: AGHT+IF8MBawyaHQB5S+RKajJ3drh/pKZLC5cwwcFHYMaxZ2ksPU8t5LndGE/n7dpUqGBY4jfv/rvw==
X-Received: by 2002:a05:600c:3d95:b0:40e:6587:edc8 with SMTP id
 bi21-20020a05600c3d9500b0040e6587edc8mr2787285wmb.91.1705928380346; 
 Mon, 22 Jan 2024 04:59:40 -0800 (PST)
Received: from toolbox (31-10-206-125.static.upc.ch. [31.10.206.125])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c4f5500b0040e4733aecbsm38994878wmq.15.2024.01.22.04.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 04:59:40 -0800 (PST)
Date: Mon, 22 Jan 2024 13:59:38 +0100
From: Max Krummenacher <max.oss.09@gmail.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: sjg@chromium.org, vigneshr@ti.com, bb@ti.com, m-chawdhry@ti.com,
 alpernebiyasak@gmail.com, nm@ti.com, u-boot@lists.denx.de,
 vishalm@ti.com, jonas@kwiboo.se, sughosh.ganu@linaro.org,
 lukas.funke@weidmueller.com
Subject: Re: [PATCH v2 2/2] tools: binman: ti_board_cfg: Check for linting
 problems
Message-ID: <Za5munT0bYuZ5bio@toolbox>
References: <20240105113917.1117945-1-n-francis@ti.com>
 <20240105113917.1117945-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105113917.1117945-3-n-francis@ti.com>
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

Hi

On Fri, Jan 05, 2024 at 05:09:17PM +0530, Neha Malcom Francis wrote:
> Use yamllint for checking whether YAML configuration files are adhering
> to default yamllint rules.

If I understand this correctly this patch now runs checks to verify
that yaml files which are part of the U-Boot source tree are correct.

Shouldn't this be done when one commits a yaml file, i.e. in U-Boot CI
rather than repeating the process on every build and thus having an
additional dependency to build U-Boot and additional build time?

Note that in openembedded there is currently no python yamllint
recipe providing the used python module in the regularly used layers.
How do you plan to integrate the change in the OE U-Boot recipe?
At least our OE CI of latest master now fails (for a TI AM62 based SoM)
as the python module is missing.

Regards
Max

> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Suggested-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since v1:
> 	- add yamllint to requirements.txt (Nishanth)
> 
>  tools/binman/etype/ti_board_config.py        |  5 +++++
>  tools/binman/ftest.py                        |  6 ++++++
>  tools/binman/test/323_ti_board_cfg_phony.dts | 14 ++++++++++++++
>  tools/binman/test/yaml/config.yaml           |  4 ++--
>  tools/binman/test/yaml/config_phony.yaml     | 18 ++++++++++++++++++
>  tools/buildman/requirements.txt              |  1 +
>  6 files changed, 46 insertions(+), 2 deletions(-)
>  create mode 100644 tools/binman/test/323_ti_board_cfg_phony.dts
>  create mode 100644 tools/binman/test/yaml/config_phony.yaml
> 
> diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
> index 94f894c281..2c3bb8f7b5 100644
> --- a/tools/binman/etype/ti_board_config.py
> +++ b/tools/binman/etype/ti_board_config.py
> @@ -9,6 +9,7 @@
>  import os
>  import struct
>  import yaml
> +import yamllint
>  
>  from collections import OrderedDict
>  from jsonschema import validate
> @@ -18,6 +19,7 @@ from binman.entry import Entry
>  from binman.etype.section import Entry_section
>  from dtoc import fdt_util
>  from u_boot_pylib import tools
> +from yamllint import config
>  
>  BOARDCFG = 0xB
>  BOARDCFG_SEC = 0xD
> @@ -244,6 +246,9 @@ class Entry_ti_board_config(Entry_section):
>              with open(self._schema_file, 'r') as sch:
>                  self.schema_yaml = yaml.safe_load(sch)
>  
> +            yaml_config = config.YamlLintConfig("extends: default")
> +            for p in yamllint.linter.run(open(self._config_file, "r"), yaml_config):
> +                self.Raise(f"Yamllint error: {p.line}: {p.rule}")
>              try:
>                  validate(self.file_yaml, self.schema_yaml)
>              except Exception as e:
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index a4ac520cbb..1fbb0fef1a 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7030,6 +7030,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>          data = self._DoReadFile('293_ti_board_cfg.dts')
>          self.assertEqual(TI_BOARD_CONFIG_DATA, data)
>  
> +    def testTIBoardConfigLint(self):
> +        """Test that an incorrectly linted config file would generate error"""
> +        with self.assertRaises(ValueError) as e:
> +            data = self._DoReadFile('323_ti_board_cfg_phony.dts')
> +        self.assertIn("Yamllint error", str(e.exception))
> +
>      def testTIBoardConfigCombined(self):
>          """Test that a schema validated combined board config file can be generated"""
>          data = self._DoReadFile('294_ti_board_cfg_combined.dts')
> diff --git a/tools/binman/test/323_ti_board_cfg_phony.dts b/tools/binman/test/323_ti_board_cfg_phony.dts
> new file mode 100644
> index 0000000000..441296de4f
> --- /dev/null
> +++ b/tools/binman/test/323_ti_board_cfg_phony.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	binman {
> +		ti-board-config {
> +			config = "yaml/config_phony.yaml";
> +			schema = "yaml/schema.yaml";
> +		};
> +	};
> +};
> diff --git a/tools/binman/test/yaml/config.yaml b/tools/binman/test/yaml/config.yaml
> index 5f799a6e3a..c2be32128b 100644
> --- a/tools/binman/test/yaml/config.yaml
> +++ b/tools/binman/test/yaml/config.yaml
> @@ -10,9 +10,9 @@ main-branch:
>      b: 0
>    arr: [0, 0, 0, 0]
>    another-arr:
> -    - #1
> +    -  # 1
>        c: 0
>        d: 0
> -    - #2
> +    -  # 2
>        c: 0
>        d: 0
> diff --git a/tools/binman/test/yaml/config_phony.yaml b/tools/binman/test/yaml/config_phony.yaml
> new file mode 100644
> index 0000000000..d76fcb3b82
> --- /dev/null
> +++ b/tools/binman/test/yaml/config_phony.yaml
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Test config
> +#
> +---
> +
> +main-branch :
> +  obj :
> +    a : 0x0
> +    b: 0
> +  arr: [0, 0, 0, 0]
> +  another-arr:
> +    -  # 1
> +      c: 0
> +      d: 0
> +    -  # 2
> +      c: 0
> +      d: 0
> diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
> index a1efcb9d4b..4a31e69e4c 100644
> --- a/tools/buildman/requirements.txt
> +++ b/tools/buildman/requirements.txt
> @@ -1,2 +1,3 @@
>  jsonschema==4.17.3
>  pyyaml==6.0
> +yamllint==1.26.3
> -- 
> 2.34.1
> 
