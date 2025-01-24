Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E4DC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 04:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E144807B4;
	Fri, 24 Jan 2025 05:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eLOTUBx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7808A807E4; Fri, 24 Jan 2025 05:37:27 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE38780780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 05:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6e9586b82so151442885a.1
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 20:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737693443; x=1738298243;
 h=mime-version:content-language:accept-language:message-id:date
 :thread-index:thread-topic:subject:cc:to:dkim-signature:resent-to
 :resent-message-id:resent-date:resent-from:from:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bk3I2zkpYS1Ri4AM6+Mhy6Nz8/FKYQcvf1jsfPtqxgA=;
 b=jaRY4OlM7ZUV7hzapFM+EEeICqHOTBDPKFKAY+GqUWNKgwnJdHaTM/xfq4FrNXXbK7
 1j3hykiCzg7DGjbe3OjY4tMWG1zbwDvlBzKkG5jocklsi3L+lAJacd5qqToWZ86dfNqb
 jG3xLumzZiRNwnxLdyUhstq0kM47qfq4Qb7cFHWLpYEeX8zW7JQI7tIdywohBG+i/FjD
 dlctNfWx6J3gYLbhRdmkw3wfjKfcaYj+bJQPeIaR1z1/PQZ4CxYFSYqKu6Zq9vbFozfk
 rOzKK+gB1uTblUkLP3ZxOIy9IOkjYW6tu959OoyZ9uxPfd6vBePf7JvcudjLCQtLEuJa
 QKCg==
X-Forwarded-Encrypted: i=3;
 AJvYcCUHbuFGZlkw19sPW0m8R7sOkrE860TiV/QzMh8IFPVW685gDe7q1D96NcMdTPA22rXfBpAKv2I=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3II4ajmL7v4djNXZvYlqpb4yfBXEplY4msswO2tMBMfLPXilt
 6K+f/eCcTMFoivoIpNvj6ZP7siWlohdYYY7iOPIng76Co9bDjiYNv5bpM0JzFWzuFjDeZh3z3we
 0nII=
X-Gm-Gg: ASbGncsfNzsJ8EimTHa0iH/5ADc57bV1gtGCeeKoRTu4M6u3lIQMjpOXQesIo5YcKws
 BxvJpeiR12yBS5p15pAj4XXpYmoLlbAOGdZ8LDLYb4jCKE2dn+mlESJEtxSlsdNShVToOQA3L6B
 0qruD0rdfIsloHya2MtOp4tS9rCbNdz6aGRJfyyKhpqNuZU+iRnCEjwmnGUf7LR2jPWbKPhOrgW
 DMExmSAKiIQzU7ox0hnIDeWjua0lyK/hWU3fD/+MRmAFYIJ9+SjyxSDEYaj8YVff7hZ2I+qv8m5
 1o2r
X-Google-Smtp-Source: AGHT+IFTTz+8AJlMM+Pm/qPVybpkO5NZpDhALafWPkGNkZDtGIAGAhtR2TR3awq2GVj0sK5+N+MSFA==
X-Received: by 2002:a05:6214:48d:b0:6d8:a2c1:2bf4 with SMTP id
 6a1803df08f44-6e1b21343aamr348622716d6.6.1737693443563; 
 Thu, 23 Jan 2025 20:37:23 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e20525abcfsm5190096d6.60.2025.01.23.20.37.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 20:37:22 -0800 (PST)
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
From: "Chee, Tien Fong" <trini@konsulko.com>
X-Google-Original-From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
Resent-From: Tom Rini <trini@bill-the-cat>
Resent-Date: Thu, 23 Jan 2025 22:37:19 -0600
Resent-Message-ID: <20250124043719.GO60249@bill-the-cat>
Resent-To: u-boot@lists.denx.de
Received: by 2002:a05:7022:723:b0:92:a96b:1d2a with SMTP id 35csp645059dlh;
 Thu, 23 Jan 2025 19:32:26 -0800 (PST)
X-Received: by 2002:a05:6214:e8d:b0:6d8:a967:8387 with SMTP id
 6a1803df08f44-6e1b2134315mr412292326d6.1.1737689545936; 
 Thu, 23 Jan 2025 19:32:25 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; t=1737689545; cv=pass;
 d=google.com; s=arc-20240605;
 b=NgVphcf5VpkQOiBXC0e6FF7yK5rhLdFIEeFBckIKH77XY7yN0G45SX3q8lEOKwqsnS
 u4PxT0I5HsBjm6I5SYkBTkge+iPAFsMJHtJESlri+DpSsw1hSit1P8IVLys3fRS9Jz9s
 OdgDfCyu6F/ozrbtYmy2o3hLxuiIuZgObCpgbuXQa5hDNdH3FN0xGs2ojDMgYKYaepnw
 NaLHivOqIUtAC41BFd5hmht9YcCPJGh1k5HuczUBsbnIXFo05645Sgpf32BLBP8Cb9Pl
 eanpXwF+ocjNkAoMl6wGR9UjIMi+68QSppDerEOkQSqmAaXcKDLgZdXAnIjTXccLPg2q
 Me1w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=mime-version:content-language:accept-language:message-id:date
 :thread-index:thread-topic:subject:cc:to:from:dkim-signature;
 bh=bk3I2zkpYS1Ri4AM6+Mhy6Nz8/FKYQcvf1jsfPtqxgA=;
 fh=Gj+8c10N4ZnBtSCBOpDH5VV37oF2/CyNO1J6xr96RN0=;
 b=Q+KppvSq8RmLxlB9oe8eEAKac8n9k0mKd96ej+JOb7UxWBuL/aJymBiabT4fvBy7xb
 0ECdWtghQWY4Fk//u9i5n1Pp3tDHGJ2uUnecmNXs6z/0j+MrOIoV0536mVprHkzVVdlk
 yu4xF9QLBXXwYpBChjtXuSyx0f0ltzzzw5K1MZN6XZHOioh8yDeThXdzcjBxvNUo5c/U
 lHWn2wrZSjrkIkX9u5gAhhHgjJUkpyChDbZX1wAt17zsbUZOn4qGuqV0CBU78DlQE1v3
 QsIsM2ySXJ13hWTzQx5RmjpQiCXYfnWbkqnazOHqDWEhOkHDPc5DeAMPGBSmDjC6bba6
 RQoQ==; dara=google.com
ARC-Authentication-Results: i=2; mx.google.com;
 dkim=pass header.i=@intel.com header.s=Intel header.b="eLOTUBx/";
 arc=pass (i=1 spf=pass spfdomain=intel.com dkim=pass dkdomain=intel.com
 dmarc=pass fromdomain=intel.com); 
 spf=pass (google.com: domain of tien.fong.chee@intel.com designates
 198.175.65.12 as permitted sender) smtp.mailfrom=tien.fong.chee@intel.com; 
 dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
Received: from mgamail.intel.com (mgamail.intel.com. [198.175.65.12])
 by mx.google.com with ESMTPS id
 6a1803df08f44-6e20601ed50si12104966d6.387.2025.01.23.19.32.25
 for <trini@konsulko.com>
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 23 Jan 2025 19:32:25 -0800 (PST)
Received-SPF: pass (google.com: domain of tien.fong.chee@intel.com designates
 198.175.65.12 as permitted sender) client-ip=198.175.65.12; 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737689546; x=1769225546;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=cdiLDRhzOKbXCWro8aDCjAKOYO2IhjvtwjEAKuSncX8=;
 b=eLOTUBx/IheE+omxtwC8WU76eGrEVjvg/CZkTk8AbugVTaA6kirYPhPR
 U8ue7zD1EziJKO2cPYWg17uJitDLMt0hall/nJu2S7KwI18k0+WGCo3Nd
 PK+WNG8fVRI3PK0566r419Qnd9dQ2a1lW4RPUpdxzXLu6Fi1mVfYmA1WP
 eeDvobXhJ3NHDgTB43tStR+tpTOPkTLpgwAeo0Umdy8V6pj91vMwg9xq6
 mUlbp5/5Jtv+Q38yqpterSWw8W7UZix2USayWJTjArzluDDCnCA1ugoYR
 9wt230Sd5vprxYEVpedMJmUdv3hyz8kGzNJEi1Ic2y5TO+2jJlRQrN6Lv w==;
X-CSE-ConnectionGUID: fl7V1RZuQWG7toHiVrDniw==
X-CSE-MsgGUID: lsR9uiVpRySEii1768z5Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="49615516"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208,217";a="49615516"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 19:32:25 -0800
X-CSE-ConnectionGUID: tZ60M5pkQeCMe5Pj/AvqQw==
X-CSE-MsgGUID: 5iU0eLwdSfeR/O2TX2l/qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
 d="scan'208,217";a="144897957"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jan 2025 19:32:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 19:32:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 19:32:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 19:32:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuHO9Bt8cgYY6XPm5Aw+zuFTURHIlaC9bvxgr5ILrVf45uiI+W25p/m8PLcmOb4UBykLkSS0e6tyM0DYfe5D8h8VusIw7g8Rp2YegeVywQ2y8CQLyrExdnS6M9q53V6D5L8LHYhGH4TRASBpgtnhqSi+QkCqsCEwJk9iHhPYHv8RAK+vsZh3i0zE2adTn+NFTjPXTorSHy4b8Qw4hJG1lh/9Afk0xxc5/lDVJUdhiDy1ZWmIQnXVWV8Z/Ek4XCIMZYpiL3UsiYnnfKtFH7MqvrfmTYaYTgZIMjbgxah9kQucSYOJDShPQPMCHrurOyyIdOIzXbOCK5n/iwnVP3IVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk3I2zkpYS1Ri4AM6+Mhy6Nz8/FKYQcvf1jsfPtqxgA=;
 b=Kz+wEKH0XY9Hc2FnVzScckEE52tR+k7/+Z1MPaDJ4UM9JE43j+xltV5zpP8PYjzvqjnI0BMNFBH/onzQM4G6rwJI4v79UXvt2D0HeGOwYzKWvOCoaVFhXtcstnSRQXhjn7MJBz5RFNvJCO9kniD13Ggdx2z62BoqTG6DfOGqmhB/Szh10sbHPKgUJXTKvxE2e0jvUq5msrrLujOhV7yfBuLxlfJWdraSs4sbuQvMK8uCq3JIX6THPf3N4JufMtO6LAZZQNtemU01lv875uwmiZhs822yc5X7gEz6Uk6+AN47fQbbm/i6+XvmMPQKXMLqqUbxVacwxbLpHVQ8eckzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 SN7PR11MB6799.namprd11.prod.outlook.com (2603:10b6:806:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 03:32:21 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%4]) with mapi id 15.20.8356.014; Fri, 24 Jan 2025
 03:32:21 +0000
To: Tom Rini <trini@konsulko.com>
CC: "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Ng, Boon Khai"
 <boon.khai.ng@intel.com>, "rhs@riseup.net" <rhs@riseup.net>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>
Subject: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250124
Thread-Topic: Pull request: SoCFPGA changes for u-boot-socfpga-next-20250124
Thread-Index: AdtuEDl/H76glVEBQ26AGrgnrsrzZA==
Date: Fri, 24 Jan 2025 03:32:21 +0000
Message-ID: <DM8PR11MB5592EAEC1756EEA4C573E82ED2E32@DM8PR11MB5592.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|SN7PR11MB6799:EE_
x-ms-office365-filtering-correlation-id: 44a3cbda-0e18-4b8a-0115-08dd3c27b661
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qk6dDETOPjmW+z0ffvEyVeIZCvYINHZVZHacZbA3ox3Pm/23vrZPuNab3AtR?=
 =?us-ascii?Q?wuhlWc3Vicvl15aCecpohWjyULLdDsWoJwyucrfeMreQQjwIqTusHBSQQdku?=
 =?us-ascii?Q?lMoUPisJhBoc0icxZsaJUPEvhRj95FeVGKlvMPEFlkYjALUCxFcJzfHC+00u?=
 =?us-ascii?Q?COSOO8aU9pl1AuRbESk4E/ei8g7535JhmeL65C0DuIUPloTDhXJKBuBQf30G?=
 =?us-ascii?Q?aX/720GwWS0PH5zrri6CbeckUDptzPKzAy+TP7y4CQHl4EzU0my+4nkRolvn?=
 =?us-ascii?Q?uegXjH1lQOalyu5+BoE0EuM7m5bJwig3RvgKB/kYSTou1S78JC0Jy5I9bvwW?=
 =?us-ascii?Q?088x81P4OoqaspS7j8PlwH0W860Bdr97DAw4DG6GMLAv7eA3aeTeOP0SQmOU?=
 =?us-ascii?Q?e5baRrsxqDdi5gyo8FBoRbs1uA7vdYBaoz9r6S0XPlpAC/dvYHYy5TpAzTae?=
 =?us-ascii?Q?nsRMVcFr2ZxxCDSdngadLV2BanDrvw3VMpu1eOFUzVC0H/XALO8wNSEkEsgu?=
 =?us-ascii?Q?uhXHIcfIA6+z+1k/9rjw+DUThUXcBN9VNqRDK7GgqC80VwGcBGlAt+UvJ5qc?=
 =?us-ascii?Q?ii4Qy/aFdmipEmYXetOKW8vijanIcygBwLbqrRVZ7rfhCG2ytlxxPbICxSPN?=
 =?us-ascii?Q?mATvISHRVzpwZx6rFKQ42iXkvgWfw/DQCuYhDsbGkGsaKYamVTTFVRMdcFEK?=
 =?us-ascii?Q?OnkVQp/p8JDVriCrnpxW2qKYxTYtQNxWTlpKl2yNkqmUeHiFW6VczZ6FLjTx?=
 =?us-ascii?Q?27ShTolNgAiDt2eBcXX1uVRrt9M1gPZ4eSf5zEtJqPSSGyJLpHY6rzHjrS6h?=
 =?us-ascii?Q?psagbNRkzVk9pSW+UGhcokl44SGzpvDBP2tgW3AlK+ZIgIeev0hvoTQNQ+9g?=
 =?us-ascii?Q?ZOiyoREhXw0U0C5x+wEH7e5nZVJgcg/uT3Ip2PqcjzD8haQB6XdWYVB561ui?=
 =?us-ascii?Q?am1+aYswREdX1ciFsuJ8a/HyVDLD2u5QAvlgACMDf4UALxKkx28PKeIoSLMy?=
 =?us-ascii?Q?wlAfF4OFAorZi4UUNQAvVERarwbL541bpiS2HPuX2r+iNrSfCSMUIbeHXWLy?=
 =?us-ascii?Q?UinJG7U63nGwCYGbdJWHaM0KMX2CavxDOWDGeJl5AI1/a79LONheOYWYTnq4?=
 =?us-ascii?Q?augGgSPMrhsaEn2654cz4Q1zHVJyPp67tDDXUpX5AJdC5zb7Y032lDJuAef9?=
 =?us-ascii?Q?fagVlcCLCeile6ieypt0JkW6MkwDLfR/DgONf/B6SWYVLAstSkOXD8YYAO8T?=
 =?us-ascii?Q?StkisUnbPOMa2rCo8D7Vi5plGn7t5OLOahc6xs/x4tLf7pgzLetUsVI/oXpX?=
 =?us-ascii?Q?9PKOYAnUrVlVbytG5IZ9VaXWrsl2CAMqvREkXIShohTBQXmL/f33qU7XOzKM?=
 =?us-ascii?Q?/XzWIrkOB9DzXR8WJ8o5vKNZtpIr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S4i30bdyxg5jMyx87SLGTkTIaIP94PnZYSfUn1dSj0m4O7NfaJ0tfJHEETZ0?=
 =?us-ascii?Q?fgu6ltaJoj/oGzvuXAcAPlxYMZoKGjQ4TA+S14OqfOc5oCDLSKV1aCOeF2/z?=
 =?us-ascii?Q?oxHI/0FKlHQj5mIqu5VedJpXhcLhSvS+Rkz3GCKgjgZmzIpfVUtV5fxT6ot9?=
 =?us-ascii?Q?Ru9yHJBQ8rhygGNLEwPu8oHCf7kFNvo1FD2cnTLL+jDQRpbCBQXY5bHObYeM?=
 =?us-ascii?Q?AI/QNt3cW1j0VtNWpLSmDdso/kM0EuXNkypb13xKnPyzNTPPGDT5bfDDw3H9?=
 =?us-ascii?Q?ncBb/5vJz/mtFTkTP6Vp8Nunu766XgyAyZJZxA/v4NOayNwgVlw/me2+ZGEU?=
 =?us-ascii?Q?ipolMSdcUpJPvkd+fgunxkDWRoankjOQRExthFl9rBly59q9US+aG09qdN8z?=
 =?us-ascii?Q?WB6iBydMCOyiO6Mo5Ap2wN+CUXnNHf0OXhevNrZ7HWQ2+1qDMXh4ZM4CAKiS?=
 =?us-ascii?Q?Vq2n0uWgz1UAnimAIlpeYBIoW9wmyd3eqXzCmYXpk+5wMnrMsIivPud4tyw5?=
 =?us-ascii?Q?F1YJELv6CmdbM9efFD9NT3AYeluoxStSrV1CTHiq1mWfU/l9ZQ9fO+SEmuh3?=
 =?us-ascii?Q?2DkHnapgradFiCuPxTXKrviBJiS3sGst4lvesRTaHkGrBhqPr7x1FVxJN1BM?=
 =?us-ascii?Q?L4pDGqbN8NZnSryUx79yA7iTv+0R9nKPKDllIwgjVDObRULUuT0djF+KfxqH?=
 =?us-ascii?Q?7OvUZ6sTDcIscD734hF+ZJd6VzM+r2Mx1ut1koNwBrClXfLLxnQHeqwQU346?=
 =?us-ascii?Q?LuN1ZFk+rZW5/B1xI2fqXbJFDPk/0u5oiIdcaQBkJV9YKbPPrOI1hG9rilqL?=
 =?us-ascii?Q?ngBw3kkD1o/975AZ5YR/lfuy3oSlwUuhE0DpT7m0Gp89rUCqeaWGGdecXsCN?=
 =?us-ascii?Q?XcfeLgboXwBJuSrN9gQpOgVVolBR4EheZrosA7b2Y/PLAAVjxKsNAjhQJcKa?=
 =?us-ascii?Q?0SuwPUl2iwTwP78oCsX7Z0pOnUen2h26FHzQGx5aoXWM6A9h+7wQJ4FSEOx1?=
 =?us-ascii?Q?4UG06vaOckbv29Cv0UzIDQgO1/GPY//oJsCbhg4GnahxfnQb/Qbj7Pw+BEfw?=
 =?us-ascii?Q?cVqIR8C2hxw62UYSc/uR5iNwKNI1fGrgp+6IPqkdKDQaGYdmNOrPsOoL1Ix+?=
 =?us-ascii?Q?IQ2eEGxNtbqAHd0E9mVYbZ+vXAABXnKAz9dlGkgvCwLlaFNAphxZ3rd2LC51?=
 =?us-ascii?Q?DFwR7N+Xj2FcZFOnHv9cjTBhkr5pPtb1PCCmgHRTVh2g+NrISNyVpGOq5vYr?=
 =?us-ascii?Q?Q3GKjf78/pd54d7TL7bYo48IkECEiRyMfOmKwTCuEWks6Oc52+wCBjQWwEQi?=
 =?us-ascii?Q?8rDenA/yp9Xwue58OXbtbjb39R2QxDmeDlXTmpLp4c8yFE6sk1HEXcr1RL15?=
 =?us-ascii?Q?xb/SNEvaOvHumLSbmjg6QM/BSIoOKbPmxe6wQfS/CRQinBGcPyv7hvn9etYf?=
 =?us-ascii?Q?pqlAwjZ56vS8Fo3AzrCpSN4k9S3vg0y/sEy2qfnAlZrIML+bguqJc039r0mZ?=
 =?us-ascii?Q?mnFqPu5v6HoLX/NCSePTwtq4YkZQlxWIsdLcHgM7QISUg62jk34TIfBtEhV7?=
 =?us-ascii?Q?v/InvttRo72rmeLOw/Qbw9bMLFoJCfY27yahw7Uz?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a3cbda-0e18-4b8a-0115-08dd3c27b661
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 03:32:21.7213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWA8i7mnx2fV1d2gp7gfaf8qmc+nFnjg+uDwt/xi1piu81THrSYe05BKfFH1sLJID7ey32QGoo4qhfuXYG41TsSaWTCZ23WaC+rhBEXdxqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6799
X-OriginatorOrg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear Tom,

Please pull the SoCFPGA changes for next from u-boot-socfpga, containing:


  1.  Bug fixed for doorbell in secure device manager mailbox driver
  2.  Enhancement on SoCFPGA dwc_eth_xgmac driver
  3.  Enhancement on DW MAC driver
  4.  Improved the error message and status for SoC64 device FPGA configura=
tion driver
  5.  Updated existing watchdog in system manager to support new SM device

Best regards,
Tien Fong

The following changes since commit 2eed5a1ff36217372e19f7513bd07077fc76718a=
:

  Merge https://source.denx.de/u-boot/custodians/u-boot-snapdragon (2025-01=
-22 11:23:35 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-boot-s=
ocfpga-next-20250124

for you to fetch changes up to 60d96038d7ca9681e926a22789613a983ff9bf9a:

  fpga: intel_sdm_mb: add support for query SDM config error and status (20=
25-01-24 09:56:34 +0800)

----------------------------------------------------------------
Alif Zakuan Yuslaimi (1):
      arch: arm: mach-socfpga: Mailbox buffer and SDM doorbell improvement

Boon Khai Ng (4):
      net: dwc_eth_xgmac_socfpga: Add support for rgmii-id mode.
      net: dwc_eth_xgmac: Add device name for the error message.
      net: dwc_eth_xgmac_socfpga: Add support for distinct mac-mode and phy=
 mode.
      fpga: intel_sdm_mb: add support for query SDM config error and status

Muhammad Hazim Izzat Zamri (1):
      arm: socfpga:agilex5: Fix system manager watchdog mode setting

Rufus Segar (1):
      net: designware: socfpga: Add RGMII-ID support

arch/arm/mach-socfpga/include/mach/mailbox_s10.h          | 218 +++++++++++=
++++++++++
arch/arm/mach-socfpga/include/mach/system_manager_soc64.h |   2 +-
arch/arm/mach-socfpga/mailbox_s10.c                       |  16 +-
drivers/fpga/intel_sdm_mb.c                               | 641 +++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++-
drivers/net/dwc_eth_xgmac.c                               |  82 +++++---
drivers/net/dwc_eth_xgmac_socfpga.c                       |  27 ++-
drivers/net/dwmac_socfpga.c                               |   3 +
7 files changed, 940 insertions(+), 49 deletions(-)
