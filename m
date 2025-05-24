Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1681DC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 20:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB84F8366C;
	Sat, 24 May 2025 22:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QZoL8V5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9969283043; Sat, 24 May 2025 22:38:01 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941A983043
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 22:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4EqwfpUGFmoVRZ3+HB/JaX77q8KCuMesnNdrRwf9/FiMwuL9gFlinegX3wff1ajG1hrfzzHPNbCZlGjwO9kFasGrbeBKFZodKjRiBdwOkRrDb5CIQM2/ycWKqNNJIkBHNAn12SAMhRorJnTMwZQOgQTHoMa+ntmKX8h1F9i0ya91VPvV7qxL91E9yUbZHJto+PD3oQCzH3/kWJaPnrWn9tt9CQOI9OihwMwuWWpT1WRER/z3oeHSvY0cVN447fTb6A+MJhSObvMu3/nqhlGkiy8824lpw32lHowTMsvDy9ZykfQdabq5AyJQDMyquNqm5odzo0pRW6M0s29xUtwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S+4JKiV1S+uKqvOhbo9F8TJTVGunzx3Xz/gCu8jq3k=;
 b=TvtNqzfzr69gd1/x+Ffe7BYLFTobBIKZnuSkrycMr/XRi/3ViGJfXfpKPTKfNu5KG/z8XUrBzBtejae5XbG6j8PwX+frlhPBf5fS4/5B7Xep/RtB7D+V7YZRKika7wCD1OGgOvsCTwIHn55Hb0M1iMgpxapwj6ML8iD4SQJE41bcLeaYbZYPog3DbNGxlqZCUCm+Ls09YSx5R64HHZAL+LTWSPbCrf7/PIK3a3cATVW9xszN8IiqigyIRPaDFIRwhNnZywGm4XxTdgLHyNEMxFA+PDCnHa3JqnCBoVCgJ1NBuOmAm9j9JPQ5D0RJNrEJixfQ54+rXk/wY5L/1+3WWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S+4JKiV1S+uKqvOhbo9F8TJTVGunzx3Xz/gCu8jq3k=;
 b=QZoL8V5iYGoDhzlvaMxhB5O2UZ+cg0MnOWdySAOoCa3HfgqBkLIo7/vw7OFeMLe8K87aDC8oWN67J8vXHPIiSWD06vUm6qJL4D8Zx55QSO6H8Xnuq9lDMHiKz7gON7zlUL/sFGjEVyG4iRB9mDH/HG9cx5gBCECqEU9Zi1x1AKZpRIWXY/BhZg8hyGvxtHlASibBSmXSdCn8nCUobmMv5niL/bzg+ICWFWYuq58anVvDm5zz2nbNn7OLdvF3tbx6EvipppLsB4prvKReeoxeFRuo8goA+DOU5piSTlcnfKEFf2b59QQhSjc8b3r1EZg12p3zW0AOnGu+cqXshZZM+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by SA1PR03MB7100.namprd03.prod.outlook.com (2603:10b6:806:339::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Sat, 24 May
 2025 20:37:57 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8722.027; Sat, 24 May 2025
 20:37:57 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 3/5] doc: usage: cmd: Add documentation for fpga pr command
Date: Sat, 24 May 2025 13:37:35 -0700
Message-Id: <20250524203737.20541-4-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
References: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|SA1PR03MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ef8610-6ab3-4dda-c20a-08dd9b02ddd8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6pdm3mSWpmjjZy9Fbm0J50vx8D2vs6afiQw0L9FmBj2+J1Y4WCw8IBqTvTb1?=
 =?us-ascii?Q?1iKRQULWYEtLpFYYaiXicEe4ZH9Pb146W3Ji7AwzB545fPmdFP4kaT0yOMls?=
 =?us-ascii?Q?Yw9edZ+TrGQhnazzW4kFMnPVGVa6eDacJyWlm5mNo7XjDkScEGv+/ZC+QlkR?=
 =?us-ascii?Q?HmsLMQ4AFSRaYhfUw5Gq9yHMRyvWAvrUpu/zTxAgcK4vNHK/KDqJHJY9AFFn?=
 =?us-ascii?Q?Y1yWw+d3b+GVwgGMiJfCMdZdJBsFg8gtZu+57cPE20iorH8YQSWVOp9yHX6A?=
 =?us-ascii?Q?eL3Xy1Hh2m8XZ2hnKtDbLITB0SLlZXmlVEdQdEhy/g/8vd53BN0zYX22n0aV?=
 =?us-ascii?Q?KPN/ehgHvL0UCDs+KVirypOmtEYkDy9BgvwGrDHXjWsC458yz7A/2uS58hwj?=
 =?us-ascii?Q?usSPKHhJKsXfvTMEnVZ5eIQWctsXN93lmVhcrcCmHnHlNxB29ghChmS0Ic9M?=
 =?us-ascii?Q?vcAfOrm8E2p94BwOxUb+LTscuhCX3STg8Rfa7w1Rc9+pil6ytvUeQ8vUqsWS?=
 =?us-ascii?Q?zwpjL25JCjvroWkPDGQSzVbExNnEWIFhVhoPXs9xIXJH+EHxe1wEu5dQGPd7?=
 =?us-ascii?Q?CM1Q2/evB1qwenI+o013XElOAUGvpkq3QHK3YbPDtB+rIrrneKbMraqFtY4P?=
 =?us-ascii?Q?Xj3rPsdDQGG8gjoCu8z6hYl1XxGMrSuJdmtBoBje+VZKIIAY2hBI9298TrkT?=
 =?us-ascii?Q?RzdpFcH4mC0uPcQgi+ordraMEb0oYmoAcix/a92jExIhZufvvItQlfiT4T/m?=
 =?us-ascii?Q?ffHWy1dFLIkEIUNbQVJJxUQVfwxjs+eh7rbPFlu76zUTFJb7T39VoRImcPuV?=
 =?us-ascii?Q?L6m6lHRlVchLpChuLMPWSl+hZmrTUqCyw+fzrpQa815mpVOARD9cNX95XrVm?=
 =?us-ascii?Q?LvfzC84gvlDZs7t/oS33RIx6ZhtACUcE9FHd0kv+YRsrGMVyVTfVeaG0JOiE?=
 =?us-ascii?Q?SOTu6nUT73O9kvB12OWOO8TUUzmLlEwGroJDATB1Lmr2VK8HeuNYA5buus1G?=
 =?us-ascii?Q?3GP6rh7Q0bvZqugRB7vUgshUhkIhlwaFXKN95+cEUygkVUMSxlK42debqEZQ?=
 =?us-ascii?Q?CSHLiK922jeVENaIHolArAsuNnADJ2gPDHVwhX8RX+b9Xt7hWcPZsKmGeygj?=
 =?us-ascii?Q?lEHsmN4gisuwc1cXkJfIZ13w1zjRm36mlC5NFipqrwnhtF0xJlzT1wxSBgmW?=
 =?us-ascii?Q?A/df0AbEWaYHxQ4hLxz1BcLm6k6FO/0UmJyHAuHCpZvhe6lTwbGSTuiiZPzR?=
 =?us-ascii?Q?lunfxPwUyfVLSZ3qF1WYdu0AtooOyr1GkkNywE4TaFUItHjU2amaJk9zFIAS?=
 =?us-ascii?Q?sHRXnAouklm6JETY97nDobls/eT2nVVyK9GYigAGKlTK/FEo7hZzKZdSzf+1?=
 =?us-ascii?Q?H06s9gCVcaPOfgB0b19y/iBYkD4+WdnTrSiQEWANpL6x+jFRxAC0QE7515nb?=
 =?us-ascii?Q?Cr1AWkPk1NE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uQrGV6/pQn4viEQo79yhwXTtKTMSJ24Ci5r9ThQoIPw/mEE6tUsONETi08cu?=
 =?us-ascii?Q?NWRFa9XonGeNVVAAevsVKmuBj1z7Okk1uZlKL1IG+HaRocybFJSanTAjStLc?=
 =?us-ascii?Q?tGfENYjWV4xZ3SJE3ogAa3vwc8IXM9E0BxA8gJ/2DqSlA+tNwHwtXUFTJHSA?=
 =?us-ascii?Q?6SJaNnqRcfvdBeVlwLqe6ty3HhtSjvbzxGXDcYunVwnA+PLYqCXKfWBGDUKS?=
 =?us-ascii?Q?og0aUoJc8ObGKqtSi7ZEgJRY3qBtfVu7OCqgIehvUS1gjQ6qdB98PV6gYhZt?=
 =?us-ascii?Q?L+5SjoKCB0LJg3gHqbqvxk+pyogyi77x0cJTLP0U0GLR7Rh75pKm4IBG7e0Q?=
 =?us-ascii?Q?bfRoMM145Fw6pY41qQxkIRAUiuNAxVq/3+WDXoGGG2UMOcFBtStqiXZOHgJg?=
 =?us-ascii?Q?fRgw/qeR8yBmUjTSZeQSAr4CcpGbBl8YCDVvv8PbPuUEeh+VUQ65eEYOiwRY?=
 =?us-ascii?Q?K84NS1UwVZNK+SD6kLaRK1LkpnqAjZtFHPncAwm65/oxkJ2UnkK+YPtb+skL?=
 =?us-ascii?Q?kvNBUTEjZ6ij5uzbzNHpKRV0/Ad/C4W7yN+0diASxVGlhiXJqimgZR5iOb7C?=
 =?us-ascii?Q?EZELCmTWhn7kGARTRjBonCKXDBHoe9gyQEzRzbJpzZYOngQEl4oC3YdbQV+4?=
 =?us-ascii?Q?s6Rf+Ep85Y1SH2eiOoaGPY8KBoNKzPnzSy00FB6ccQPxCuIKFwVu02M/8/ih?=
 =?us-ascii?Q?kwt0OoVtdOAfw/I0TJvoip4O3tFUA8Zk9jITpzxTnqGRQEATFT9Vp1H0uyiK?=
 =?us-ascii?Q?7kRYbzYwLr3iLQm/SfRFB6+9Q7nizFsUyoyMMK+vkOWvuxWh+TEKKEzhjF8z?=
 =?us-ascii?Q?pgr6KXBkeSdZ+22aHFtOokzVVohmnIuvauVKEWb2HxAo6Mb1nN85QY97EFDa?=
 =?us-ascii?Q?QJDht/fhM+xMPnAQzPwibRuhG6ni1xSov0flY850TKmrTT4xLVQasQJ9YrQ7?=
 =?us-ascii?Q?eFjUXXAbe9bKIcwNl2cLZOdKAIJIHzpX/hsUYFo4gn3Z6jNxPHtvg6OHV6zs?=
 =?us-ascii?Q?IT51w/6IGqilukPeeHpKiZu4+jX7SC2TXNwXSkhEKnrdJ4OiPPwk4aX557Sv?=
 =?us-ascii?Q?vtAzcrfVx/Y/F1OJW+iF22IG+36JzWDgZ05M6H2P9CncnLiGIXvPmeGucSY+?=
 =?us-ascii?Q?KqUP/c+HzBCplEEN/VQmmeIyS0gk4CTUubg2/9A5AumU0v21+4GHxzKixcRT?=
 =?us-ascii?Q?Qllvn1I0t9J3sDavC1Qx6dNbmxD7g1vuOynag8qsnWCh6cu6EhsefF9Taur9?=
 =?us-ascii?Q?szunMbw15HHPZBrzH0T5xljDKq2dAd8OQCA8fXphrhDzYs7kWLApsSslCY6N?=
 =?us-ascii?Q?GAyRJGfSvxMyFjsZ8F7lb4ACt1PY8d0/q+zcSw03wuXQr5Y8REWasLUVE6qJ?=
 =?us-ascii?Q?vrexVTizc93rVxqNAr7NYRq07Ixz0tXrev1WSOEv+PIvT90kfQ/sAzPxtdEQ?=
 =?us-ascii?Q?cUy30roEGn8QeyGqGGBjx7s/Ak28DnaIYBtkm5+eLMo1d+Qc8JKO39gajvmd?=
 =?us-ascii?Q?Wk8Q+R5GnjXhxNtGdmsapFIBOBdW3oOn+Vw5u8IulGmOWxJOQNtqKkBs+Ncx?=
 =?us-ascii?Q?ajCz/TK9TCqtFtGZNN4BcSeb3ct7E0d7h5Fd5TuTJpHcC8ZILQbLvIzJpJE5?=
 =?us-ascii?Q?EeVALjNGIKsSC6PmZnNMyLQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ef8610-6ab3-4dda-c20a-08dd9b02ddd8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 20:37:57.2752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naRBZqJcx7nrM9LTEv5ZtItm/OvcX0cOmWliiC5FIfcHtsFWTW8E8WliGRZgFryz/kWbMYhdJ+usvUjd98XITc7xOKSX6wxm2dKld+mVNuV5PCSAzlWvp92EV5gNIsQj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7100
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

Documentation for FPGA partial reconfiguration (pr) command is added.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 doc/usage/cmd/fpga.rst | 65 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 doc/usage/cmd/fpga.rst

diff --git a/doc/usage/cmd/fpga.rst b/doc/usage/cmd/fpga.rst
new file mode 100644
index 00000000000..5f0b6d0cea9
--- /dev/null
+++ b/doc/usage/cmd/fpga.rst
@@ -0,0 +1,65 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: fpga pr (command)
+
+fpga pr command
+===============
+
+Synopsis
+--------
+
+::
+
+    fpga pr <dev> <start|stop> <region>
+
+Description
+-----------
+
+The *fpga pr* command is used to support partial reconfiguration functionality
+on FPGA devices which support the same. General usage of the command would be
+*fpga pr <dev> start <region>* followed by *fpga load* command, where partial
+configuration image is loaded and stopping the operation with
+*fpga pr <dev> stop <region>*.
+
+dev
+    device number
+
+start
+    starts the partial reconfiguration (pr) operation on the specified **pr** region
+
+stop
+    stops the partial reconfiguration (pr) operation on the specified **pr** region
+
+region
+    region number to undergo the partial reconfiguration operation
+
+Return value
+------------
+
+The return value $? is set to 0 (true) if the operation is successful.
+
+Example
+-------
+
+::
+
+No console output is displayed when **pr** *start* and *stop* commands have been successful::
+
+    => fpga pr 0 start 0
+
+    => fpga pr 0 stop 0
+
+However, desired output can be added to specific **pr** implementation functions.
+For example, in case of Altera FPGA devices, following output is displayed. ::
+
+    => fpga pr 0 start 0
+    altera_freeze_br_req_ack request 1 acknowledged 1 ctrl 0
+
+    => fpga pr 0 stop 0
+    altera_freeze_br_req_ack request 2 acknowledged 2 ctrl 0
+
+Configuration
+-------------
+
+The *fpga pr* command is only available if **CONFIG_CMD_FPGA_PR=y**.
-- 
2.35.3

