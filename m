Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2226CF9C5B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 03:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B99588C98;
	Tue, 24 Sep 2024 05:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JJK+ARKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34DED88AFF; Tue, 24 Sep 2024 05:14:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4147B888DD
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 05:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727147664; x=1758683664;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=thoaAnVVnImQR9e3LEfmwmvRn+N+1Td0FsDoVSVlTbo=;
 b=JJK+ARKXC+v+X2qjRD4iJKh04b9n2E/kYJLl9uUOdqrLUrwRFFfepvJ/
 MR8kzD5jPJm9KHFWPYA48p9NT1h+/xn7h815CEGgj16Jp03mVPH9J3xky
 msveDWcQGiXXZdtl+nM/gLQfjsWnFF7wmwrthoJNNReQbc+EZmP9AqWxJ
 gg5F8Qg9ho/QWM2RzTOUDMw5f78iSvF/S5T3uNZ3UvDMhkMBzfFRLpOHu
 ybZZ59joTSzgIvq/mM/KXFLoKLmJqsX+jGAbcanvpmy+H+Fy6GmwZ2fiG
 vzw1v1lOVJTJkeeOf7PHqOH7T9exIsijfF2z22WiMvNTG838MygQnIeAp Q==;
X-CSE-ConnectionGUID: jCUJ5XqQRf2H7KwPU3l/6Q==
X-CSE-MsgGUID: rx/Spq/sQVSniojUwsKgDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26314232"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="26314232"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2024 20:14:22 -0700
X-CSE-ConnectionGUID: QQEjWC5NSEetepnS57kWMw==
X-CSE-MsgGUID: RWYpPMN3S0eqlMzYyBqZvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; d="scan'208";a="71706882"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Sep 2024 20:14:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 20:14:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 20:14:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 20:14:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KV3MP2L2c6t/NYkbMF0ufOUxcpx/bNhkBaO6PAm04P+YUSXkVHMupYBiF8QIOesdp1SbIMll8of0X/Wu/mS50ujd1ISJWRxeHZCY0ZqsToq6rIwTpnvr+TEwxz8amXV7b4SYIYY4k98YaZLuBTTR9YOSLbCyfNnCN8o+pv8s8Qjn+yQqyonXWVsRr7mezEUiAizhIv5SR4PT6KP23Y+CmFfxe07cMB9RMVl5AHjwthyS6WQ/FatuJQS7Rfv8pduM+D5sGNPvTmNjOCjblOMUtQQwzMlScdSAynKsyycJqwfDLDoo9Ckgr+6KV3ldGv+4J3qWugfyLLSvxnbMyQPoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thoaAnVVnImQR9e3LEfmwmvRn+N+1Td0FsDoVSVlTbo=;
 b=L7tPwawDkxsShgyfMzBxBwwHjtzscVBxmqOpmqK1ucR4Ju1VPPxME60ISIT/Q74QdqoSJOkiTtWDnSyKbiJVDTix4rEVu47fhVXvajIT3+13ISzpiVgxrf3TqfsEn/tP8PcBjdbVIStx8XZ+Z4V1pXmZZ4U5axEOFZ4UV3dHzOMdIaQ/zETe9BM4boCGiub8Tl/7rikzO6+PD7hRqtByMy008ICuZ+WwyBpoOaeZ0DKiFNvslcJvh6ibJUxPIPzg7WQyvXXo1JAIy8J26boZqjDG8pTDT80NxWmikRJ0YaTdnMkd+uhewNh/n1aqnbBqRmgRSOrxXYNbLOlls0W5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) by
 PH8PR11MB6611.namprd11.prod.outlook.com (2603:10b6:510:1ce::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.21; Tue, 24 Sep 2024 03:14:11 +0000
Received: from DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe]) by DM8PR11MB5592.namprd11.prod.outlook.com
 ([fe80::eaaf:292e:8706:bdfe%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 03:14:05 +0000
From: "Chee, Tien Fong" <tien.fong.chee@intel.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@intel.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@intel.com>, "Hea, Kok Kiang" <kok.kiang.hea@intel.com>
Subject: RE: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
Thread-Topic: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
Thread-Index: AQHbCysxcBsr3IIvwUKhOtjjWPaLTLJiQ8QAgAQDArA=
Date: Tue, 24 Sep 2024 03:14:05 +0000
Message-ID: <DM8PR11MB55924FDB9E2C081EE97216CCD2682@DM8PR11MB5592.namprd11.prod.outlook.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-5-tien.fong.chee@intel.com>
 <9cc437c8-59dc-4e78-82d4-8ef479ca9ba1@denx.de>
In-Reply-To: <9cc437c8-59dc-4e78-82d4-8ef479ca9ba1@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_|PH8PR11MB6611:EE_
x-ms-office365-filtering-correlation-id: 443ebb94-0137-4dee-3698-08dcdc46f2bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bi91QndEMCsvb25TdFVIZ1B6LzJPT1dQZmlIR0FpU1NhUm5jdDlucTVvdE9W?=
 =?utf-8?B?UGY4VzdWV1pXTGRLS3R1VlhQWFJkMnRldXZqN2t4U0tBTjlsby9qMGl0QUdK?=
 =?utf-8?B?WHdxdUpuSU1EYnUrYzVLTWcrblJzMVgrdFBDU2xwUXNDT05mYWJpY2hEU1FI?=
 =?utf-8?B?MHFUaFNwT3I3ZlhpSUxNWCtNWFZnZFBOd0V0UUt6L2lOYXR3STFFWGx2aHhn?=
 =?utf-8?B?MEpVeUJTTXNDTzNYSFQ3bC91ZDRtYmlqQ2JjSUJadEh2clZjTDdiSVhYdlJi?=
 =?utf-8?B?T2dnUEsxcExvUkhjR04rQVdUaHRiVUZ3N2FzdnVYaUZrZmJjZm9TUm0zTlhD?=
 =?utf-8?B?NTYrem04bXhiSXF1bDVXMS9pTVpwdUZqZDg4MDhSQm5FMnB1N29jYmkrK1BR?=
 =?utf-8?B?MFdla1RkbVczVCt2VFBwS2JtME9wVjhXckd6cHFpb1J6WEIyZW1BaC9Bakd2?=
 =?utf-8?B?LzlNcnN6cjRSVjNxK2lwYWhkbnNBVGZHdm5kWUlHV25oK2R4eWFyQjBQYy9w?=
 =?utf-8?B?R2FicnBDOXc3WVc4UGFBTFZZSXBDcnJGSDl1K3EzcG1STmdNNDZlMU82TUMz?=
 =?utf-8?B?K2JSVW1VZDg4aWV1ZlRJVUpOTklmbXhzZjVGdFFsakc3cUF2cU4wQ1NoY0oy?=
 =?utf-8?B?SHVPM29WRmNmVURId0xUUEVScUxOREZGelVFNUxrLzJ3VVBlNEJFcGlGVjNr?=
 =?utf-8?B?OCswVEhxMjVHaEVtNUNqZElrWXJmZ0JLOEFXTTJHbzBGMGwzMnhjYTBpN090?=
 =?utf-8?B?Ky9RUlBNN255QjA1THEwZzBzVnJhYTAyd0RqU21DcnNlT2liWEh0Q1E3WXR3?=
 =?utf-8?B?UGhnZkRLcjFITy9qL1E4RFZNOVIzckR0ZmZBenhLRGZ5Uk11RlNMV2pjR1lk?=
 =?utf-8?B?eitnRFo0SzZPM0w1bnpsdEdHVmkwYW5iRFRqbUlseVRhcUIwbHhLVkpNeTE3?=
 =?utf-8?B?T2dOL051Zm1xRFVNYnVpelp0V2o1bXJwK2VaZE1sR0lvQnlDVFZMS2NTTjBx?=
 =?utf-8?B?N2xUUm1ydXFkNytCQW9lWVAvcndwNjBIN3g4Q1RIblNub3Z5SHk2VmlZRFZv?=
 =?utf-8?B?aHlWOFEzZjNWWGpQVDY1MW1rRWxlN0M1NFVsbE5OUklpKzE0azNOK1J4dDZO?=
 =?utf-8?B?bWpJWk02elRRVHppblVNK20vTjZRRG5Sb2hkSlQ2SnhIZWRYZVBoUnJLRDVN?=
 =?utf-8?B?KytkNXNIRTdGZWlTZElRSElxMFlkTEw3eEJNVGJSbDlYRkZ3Z3gveUhMR3BW?=
 =?utf-8?B?THlnWGRMQTV0REt4THBOV1hUWlMrcDU5ZFZacm0vMEEyUjMxRk5XSjdEZmJk?=
 =?utf-8?B?QlZwbUZ6eGx1dE80NEduQnlKNVZzSHhjVElpRmpCT1N5LzI3MmJiRFBQNEZI?=
 =?utf-8?B?NUJaVDE3VS9JUkZ3VFBGK0prSE5kUzIyRFJVaXR2WmQ4Z1lZSlovRlZidVRj?=
 =?utf-8?B?dTRRU01laTlpUFFWSnkzTmhlUDJDU1FiT01WdjJKS3VUMmJ6d3pUMHVjekps?=
 =?utf-8?B?TTJwcDFHU1U2NHdieEk4M1VvNG5Rb1BxU1oxcTRXcWNYdkFNRWIzOHpNVEl2?=
 =?utf-8?B?U0ZoSTFzaDg2ZjRmcFRqS1VZclhWcGdWb1lTRDdZTzZQRUVlVlNRVEFMaUJP?=
 =?utf-8?B?TU5QeTNSbmkxeWlMS3NsaGNIWkhuSk16V21NQkpKdGhFamp0V3VjdW9qYXA2?=
 =?utf-8?B?UjBsQW1iYjFlSG15RUNQd2JFOVdrbnppTUFVN2ZwY284aHg0UjdwV0g1SGMw?=
 =?utf-8?B?cjQrRDVrWDdyN1F2OHJpWjVUbnJBVFdTWURPU2x1NTh1a3Y0bUhodVU4dHdG?=
 =?utf-8?B?WEdZakt3VDVRSTB2ajRaQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5592.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anlOSVB5TTZKTXdyeno1NnZUYzZ5WVNPN0Q1RXowK2RJZU51R0FGSDk4QXNF?=
 =?utf-8?B?VVhPTk1hWjJwLzlwVjRxY0xEWXkvRVhibzhaMzByeVBYbXppbnUvcWNxUXg2?=
 =?utf-8?B?NGVlTzFSSkY0MG1pTS92NFBhUWNka3FhYUVDTDN0dlNXbnZ4c0xnSm55cTcv?=
 =?utf-8?B?dFc5ZVJ5ZUk2RzRYcjdWYjEvVVorcVJ2cFFHSEc0VEJCT25QK0dBTFhNSUlq?=
 =?utf-8?B?Zi9qZzJxNms1MkhIUmkrWTNIcXIzQTRmNkkxSjFHVm1CSzFMQkg2ZmthWnpo?=
 =?utf-8?B?ZEMxRWllcVBMRXlZN3hzZ1JySm1vVFJGTmcrc2VwYi84YVRzOUNhd1JzMEsv?=
 =?utf-8?B?MVZ0SmRKTVc4b2dXbTJmUGtpOHVUcmN1N04ycnR0aFlKaGkweWhTZlcrRFQ3?=
 =?utf-8?B?Mnl6aWtmYStpZVhjL1lsTFFjVFdCWlI5VkFPMUlEdE5McUJEdmNobU52Z2Rn?=
 =?utf-8?B?WGhMTGV1dVVqeGQ4a2xkZmpic0s5bnR4QXMwL09rdzU0QUJMdHVCaXdsN080?=
 =?utf-8?B?RTlZM3pMSm9vc1J5ZnlkMlpnN1NZSk1TS1hSYy9pUGpabHZJMkRIbE02WU10?=
 =?utf-8?B?VTZLS1VoK3RyNzZpZFlYTklSOENJM3p5SkY0TStldGZIVFZrK2M5VFdBby9N?=
 =?utf-8?B?amk3OVVvREM2anZKQnpGN1doODErbm1pRUdwS1FaajFCTGhBdzBFOUFuakpj?=
 =?utf-8?B?dmtWTEFob3hjNDVJeWV6K3loLzZGeXZTVDlTSmdDaFRpeTBaVHlsN1dMZExo?=
 =?utf-8?B?Q2F4ZFhUSGxPUmU0T1F0dXVKQVBlU2VIaGNLQ2NiUXhQcVJud09yTEp0a2Vx?=
 =?utf-8?B?ZUdOcWFkWDRuTTM2cmIySEJMQjZ4M1loUUYzK2ZEcnNSY3hvRm5XWFYweFVQ?=
 =?utf-8?B?dHR3SnRNT0tMOXRNWmpoOFUyN3hBQ3pZdEVtN1l0eHZRK0xvSWE2TTdsUnJu?=
 =?utf-8?B?cSsvTEJSblRqSVZjaVl6Z0xGL2FIU1l5OENScnhXYituSkpYSVBHQWhQanB1?=
 =?utf-8?B?TVRJcDRjekZHMlp4dHBsRXNQc0dVRW00VXh4cVlvOFVPWVpEY3cxSVh1UmNK?=
 =?utf-8?B?cGthRmZ0SkpDbzJ3UnpJbDQ0QURtODg1RWVnRjdZLzBqR3pxcjZjMTRyZVo4?=
 =?utf-8?B?Vjdva2RmczhOOEhhRWoxbWR2a3BwUW9aQXdrTXBhMHFJUDlvNEkzQW1rQVY0?=
 =?utf-8?B?QXp0UTc3YnVYeXd5dHQyTndKQzluMnlLSjE2cUVCaytNeURSc3lrNk9kU2RR?=
 =?utf-8?B?TjNSc2VZa29HRFFka2RJbFRPWkJZNXlqQURNaG84VEx6UVk5S0tFZzVUbndK?=
 =?utf-8?B?b0RjK1NoSDk3aGV1K2VVdG5Bc2ZPTDVsSnVXV1ZXcG1vb2pHL0djdTJnQU5x?=
 =?utf-8?B?TWJPU0tpNVlJZDJjZTI5SFNXbSsvTkVKS2JRNUhIRkhtbDRaemp5Tk8rZ2pv?=
 =?utf-8?B?ZVNhMlJSM3dSY1NTYzgyaFZJV3lUWWZHNVVFQ0Z0RGcvYnAvR3d0YjlIK0dY?=
 =?utf-8?B?NGJ3Yk5FdDJkVmpPNEh5TXB4L2tiKzdoVytYZlNFOWdHdEhlM2FlVFFGZ0w5?=
 =?utf-8?B?bUt3cTFYWkxCR0VuSWF2VVJWRDhTUzVPak9UTDFBcFkxYzI4bFlTYnZONHdT?=
 =?utf-8?B?L284Q0diUTg2d0lldWx2NmJKb2dieDJkb1BFQ3RIVFEvOGVSUXd3WjkrN0NR?=
 =?utf-8?B?RmRZTFpnditIUklRMmdmZ05tTHEzV2hUcWF2TEkvRllnL2l1S3lPZG9EZjNW?=
 =?utf-8?B?REFjRnBmUWNqRExMMEJud05MOFBxTVdkNERxNHkrQUNYbW1XMW9aOU1yZlQz?=
 =?utf-8?B?MWErS1RvaDA0SWRreitDSmFiRVZSLzliMXBaeVp6ZW5sS0puVzFEV09ZVmtl?=
 =?utf-8?B?anJHUUdCL29wZk13VGxZNWkySHNWendTTk56OTJrRGR5dnBkaUhiQVgxNjdN?=
 =?utf-8?B?ZEh1aXhubG9Gb2w0alBnTE52eWVCMlVNQUVXckFqeFZydTdJQWh3UlA0N2pW?=
 =?utf-8?B?TE4yVXJsU093QklNc1ErRzZtaUs2UlVQTXdMVXZZc1BveHdUbmcwR0tqOHk5?=
 =?utf-8?B?aXdOSStCNFZLSURLRENEUU9jNU0wdkhoL0xjRG5yYlZ3R3d2MmlEOWtRQXRv?=
 =?utf-8?Q?aICjrntJepp2RxhyR0DzH/xfw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443ebb94-0137-4dee-3698-08dcdc46f2bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 03:14:05.8029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RPzOuMbXADRIXxyhyholoS+nmnKBViTolvOu4OxRJYRBciULFFBHIyWvm7ZiJ24vsK/sJkCG1KBocMKolrB/m7bkJtEvWyqj3oc3b6eAl8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6611
X-OriginatorOrg: intel.com
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjQgOTo0
OSBQTQ0KPiBUbzogQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBpbnRlbC5jb20+OyB1
LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogU2ltb24gR29sZHNjaG1pZHQgPHNpbW9uLmsuci5n
b2xkc2NobWlkdEBnbWFpbC5jb20+OyBNZW5nLCBUaW5ndGluZw0KPiA8dGluZ3RpbmcubWVuZ0Bp
bnRlbC5jb20+OyBZdXNsYWltaSwgQWxpZiBaYWt1YW4NCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1p
QGludGVsLmNvbT47IEhlYSwgS29rIEtpYW5nDQo+IDxrb2sua2lhbmcuaGVhQGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwNC8yMF0gYXJtOiBzb2NmcGdhOiBhZ2lsZXg1OiBB
ZGQgbG93IGxldmVsDQo+IGluaXRpYWxpemF0aW9uDQo+IA0KPiBPbiA5LzIwLzI0IDk6MDIgQU0s
IHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBUaWVuIEZvbmcgQ2hl
ZSA8dGllbi5mb25nLmNoZWVAaW50ZWwuY29tPg0KPiA+DQo+ID4gQ3JlYXRlIG5ldyBsb3cgbGV2
ZWwgaW5pdGlhbGl6YXRpb24gZm9yIEFnaWxlNSBkdWUgdG8gdGhlIG5ldyBBUk0gY29yZQ0KPiA+
IGNvbXBvc2l0aW9uIGFuZCB3YXJtIHJlc2V0IGJlaGF2aW9yLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogVGllbiBGb25nIENoZWUgPHRpZW4uZm9uZy5jaGVlQGludGVsLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgIGFyY2gvYXJtL21hY2gtc29jZnBnYS9NYWtlZmlsZSAgICAgICAgICAgICAgICB8ICAx
ICsNCj4gPiAgIC4uLi9pbmNsdWRlL21hY2gvcmVzZXRfbWFuYWdlcl9zb2M2NC5oICAgICAgICB8
IDEyICsrKy0NCj4gPiAgIGFyY2gvYXJtL21hY2gtc29jZnBnYS9sb3dsZXZlbF9pbml0X2FnaWxl
eDUuUyB8IDU3DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwg
NjggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcmNoL2FybS9tYWNoLXNvY2ZwZ2EvbG93bGV2ZWxfaW5pdF9hZ2lsZXg1LlMNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXNvY2ZwZ2EvTWFrZWZpbGUNCj4gPiBiL2FyY2gv
YXJtL21hY2gtc29jZnBnYS9NYWtlZmlsZSBpbmRleCA2N2M2YThkZmVjNS4uNTNjOTFkMWQyYTUN
Cj4gMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vbWFjaC1zb2NmcGdhL01ha2VmaWxlDQo+ID4g
KysrIGIvYXJjaC9hcm0vbWFjaC1zb2NmcGdhL01ha2VmaWxlDQo+ID4gQEAgLTU4LDYgKzU4LDcg
QEAgZW5kaWYNCj4gPg0KPiA+ICAgaWZkZWYgQ09ORklHX1RBUkdFVF9TT0NGUEdBX0FHSUxFWDUN
Cj4gPiAgIG9iai15CSs9IGNsb2NrX21hbmFnZXJfYWdpbGV4NS5vDQo+ID4gK29iai15CSs9IGxv
d2xldmVsX2luaXRfYWdpbGV4NS5vDQo+ID4gICBvYmoteQkrPSBtYWlsYm94X3MxMC5vDQo+ID4g
ICBvYmoteQkrPSBtaXNjX3NvYzY0Lm8NCj4gPiAgIG9iai15CSs9IG1tdS1hcm02NF9zMTAubw0K
PiBDYW4gdGhpcyBiZSB3aXJlZCBpbnRvIGV4aXN0aW5nIGVhcmx5IGhvb2sgZnVuY3Rpb24sIGxp
a2Ugc19pbml0IG9yIHNvID8NCg0KSSBjYW5ub3QgZmluZCB0aGUgY2FsbGVyIGZvciBzX2luaXQs
IHdvbmRlciB3aGVyZSBpcyB0aGUgc19pbml0IGlzIGNhbGxlZD8NCldoYXQncyBjb25jZXJuIHdp
dGggbG93bGV2ZWxfaW5pdCgpPyBJdCdzIGFsc28gd2lyZWQgaW50byBleGlzdGluZyBlYXJseSBo
b29rIGZ1bmN0aW9uIHdoaWNoJ3MgbG9jYXRlZCBpbnNpZGUgc3RhcnQuUw0KDQpSZWdhcmRzLA0K
VGllbiBGb25nLg0K
