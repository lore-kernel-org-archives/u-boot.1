Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE775C44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07AB984A8D;
	Fri, 10 Jul 2026 14:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="gEXMBhHl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F1A84A0B; Fri, 10 Jul 2026 14:36:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A98C8498C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 14:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7+k+AzgiojcEXnCTRIEu7+GgOaItinnLnyv+FEQNc3VTXkzQYrHbomlqO0vdy1bx5hI2E62Y9fUF/k6oU4CRdZaBjISoGIXrhfmZckB81zHLTWZGpPLpRaufB4V/ZgAr0nql/VWC9EK8ZCzQFUVqDvt/TZ7mfpFlUXif2fnEexC0ELP+pAd0A/pHiqtIwbSYdVDIx6sUN/NWwb4jwebLkQVplIiB03Ah9a2MVx/osjrqXLJ5PmljAmVs3+/7dcES27UkXC6pMgSH/Im3RVmLp+59ckz3BWA3K1xqQgJu0XiAarcMTGnm9Z5GGeagz+1aS8SyDDt260WkmldWmREqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxeSLStYagxm+EeqFmfUxDlh20Vo8tfw14zjgm+skAc=;
 b=igulFPVs97bJV5WcbUN4zNMMBr6FjG12iCFcXbeZJ/xPmqc62C76YBrdjHMZzlFBBY5umbc7kg88SiMmuj6WZKj4FFmfNTOGu/a8RhRtwAA8939RjKLWOtm5yWC3A7BjrlzNAo0n2IbcHP+OxBrwTlsRHSk2aE163kpv/IfNn3zIOTNSBg7d780nMjHSH757QJD6voTjAFm+HbWDM2Ca7PzcAW7hE06ISmYmQXTqhYWM95waPTyVoey5rV3ZvD3oK6Iy2QxBFJ5qDjp89o9jJcA2Fv8PNBkd4B8e4OearwqNPTaTQk3HMX9t6LyuE47JrcL8rLJZlR7+hBrF0gQSOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxeSLStYagxm+EeqFmfUxDlh20Vo8tfw14zjgm+skAc=;
 b=gEXMBhHl96YooSHfpDYMPLV0THHVWRuz6rBcbFMHUftYFo6oGwQFYsKBJzvb42iGpq99epX+H70f529KOiapx/tBmiJHX2vDYhAFxrjlA04S34fpKjzoEEJ9FJz9j64zhdG/Cpo9Wv1cNX4n5jNEL/YI0iQlEYJJ4wLMXPXHSYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 12:36:26 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 12:36:26 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/6] binman: x509_cert: allow and parse distinguished-name
 subnode
Date: Fri, 10 Jul 2026 14:36:14 +0200
Message-ID: <20260710123618.2036728-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710123618.2036728-1-ravi@prevas.dk>
References: <20260710123618.2036728-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F710.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::39a) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 370929ad-5dfc-4b41-da64-08dede7fdbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m4N0yImFhz/wW9gVifH8/PfyUGEPwPx5pWDcXkA3OjkExPSy37/KOJ1uUlnoNY76jhYjTw2Ow/ZxjWWiQ5g4S/XXFOK3o31G1rz6CtL6BBjlYwNS56EOxqFGCvYPJunSQCL3190PIUZ+H25clhQ2p7ad1PNLYAncJVwnU3/MG3Bn7IOcDpqiMOeRevdZ0nXHS9BGtYGoZNac2Qu7WvssaGMcwA2OoHf5H22uSc73vjC3UiijU4rhPXWbzTIqP1T/wB1OAVPlw1R3mHRO9BIJnuyaxW0V5vkxOkfRBxvNKECHOOSZlxa1ezq5vrwORnenYhdXwTo2hwdQr4PWQ1vy5s+tD0u09n9E2KbjHHtaBeID8vcoZ1JSHzKPwuhFzDeuVKLi1ePeg4CBHHinPMdA5Ek9kYNVHAcuWhRPLDAvamHc+Wtcva073mvBQNKxDr06wW66CrTuOo41OxAJKFi9o0yYC0gdbUgSdpv2ZimSGtT0AInikwfYCPSL5mV6DSynbS6hiKqOqcGIMjn/cBMdeu3GEeE+8UTd8HhHlh9o30Fpo0adUxqZqyhuNW+6s6ZTZZCWTWVqmnxhJ/2OPJYEhdWLZZYQbm5Mg4aOBrQh0QfIR0u47NyUvhLgdsayISTCZtWmt4Vyk7E4HkRJQj1Tfgr1KZvpeHQjZAP7BJHnuU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zkoOATFxkjgjBg75sqqEVadZCAAwPVMFkcDCwthGIrwdN9Fy3p96jsauKgmP?=
 =?us-ascii?Q?WfZz01DMkIvQrq1df2TRCI7l/Cup5z0LAgwqVO1MpVCSdMG5MdrCFiVM8x0F?=
 =?us-ascii?Q?NtRBIBJIMLE/cI6+/F/1YDur+RAr4xjLJB2qfek5V6B7z3U4GNRis0xyVC6U?=
 =?us-ascii?Q?drALyBCbi6JprYuDX5Pit+a54dr3u3nB62SJgoEyWhUxTIavw4iW2yZqyJfb?=
 =?us-ascii?Q?xki68fatKy69Z2UQYpx7DHigS2HGlYT491W3rpOeSmMzJF6Gy28nHuqbIfyH?=
 =?us-ascii?Q?Xj3NAQd5rSwLN9uxRodHZ7JzdMA2pT0VhC6sqfP61TQrxSmq7rvLxb4OJi6p?=
 =?us-ascii?Q?IQ8L83Jy+yN7poDm2QbCGGDkZnyoXbbv91PtJvG39V9yYvL7cOF1+B1MGzr/?=
 =?us-ascii?Q?31jZ1ravbz2PhCGvtqa6FZrwtcIYz6Qnbf94ceUwPK4NJezBfEbYXjtLbNec?=
 =?us-ascii?Q?i9ngacJKUIa9R+x+pVVHCv0K3mCqIL+nGP7hQO4WTsBCpYBe6ZLedq3ESBZX?=
 =?us-ascii?Q?EQLIKvaihtmsdCbF2no0vk58VJMlbeOVIOV4JJZ2nP47GVXkVhMxE+OaCA5v?=
 =?us-ascii?Q?d0VqiXC6sK6RCO03VdpcT7sK4XqLpOjDy5zRd85LCLroURboq5+6Iv2kNlKV?=
 =?us-ascii?Q?2E0mbVDGa4+KtfPfJTJtlaIXQV6I3fVTc5Z9ZTaMHrlN75dhT1ksQgIBlPTd?=
 =?us-ascii?Q?47R27qWbzohgykXdm93SywZiMNs82aevieXoUWEAsU05VO//nx+EWZTLwC7V?=
 =?us-ascii?Q?PbWuCtnpOTy25JJf61aFWv4sFrDQp/aZlhspxz53y7YIoV/RkabqWajvUXGg?=
 =?us-ascii?Q?qZ6wPWQgDpvvfW2jTZIE9iUyqRGwO2IY2un4hk7+wyt84qhOaSO3AhaYLEJo?=
 =?us-ascii?Q?4YySONs32Jph2xM6ZjcZ0mi2P/XuHZZyqK5+eCQfNcDWjWoI0yXw8tlhXy6R?=
 =?us-ascii?Q?NfxPg3GSEBLaxu+YWPlunzHSo8kqzS0cLvdj9LnTFDT0XB4QAXwotH3W8FVV?=
 =?us-ascii?Q?OJYE5cSt+47nhRbJ8eFavwoklWEgq/ToL6zuJsFcNOFCb4eQMdDkExjRf9sb?=
 =?us-ascii?Q?d3bg6vL5L4qmNZsLL42+HjZP02FsaBFIHipyOsImk3RDKYz1pRJKAWURjgLK?=
 =?us-ascii?Q?vCowHaGBz6PJKEMLwikhgR+chn4iYqgYpr34VLlXY6G9Yyz1uIArMlE4LKs3?=
 =?us-ascii?Q?muumERMGWRPM7y9lkp2Bt/ppju/6SUXV/+QwNJwwAM+9/Z9nO7EQLYzqv4P2?=
 =?us-ascii?Q?8TX3PeHGN/8y2E3feczPwmAjHxrMMHXG7jacrxjL6wn/GFGBORexgHotWdr6?=
 =?us-ascii?Q?xiPlprd8TIshV4wC0dH4ooyNJOUA3EB2IP1OGv7hePW2qDHq3g1Q76i5Mmfq?=
 =?us-ascii?Q?e7gFuH/LJ31IRTyVRE5FGJBDmL3pZhJMkVdG8eYR7oX5cT4es8RRx/q5/RO3?=
 =?us-ascii?Q?CmLLt8JHCH2Hl+UcaWNgRpPOTU50WRHAJtpl/5rvWfWokBXLcI0foUOuWqZ/?=
 =?us-ascii?Q?wm7AP/dABIOsJ8VIERuuXqRaoPBsVN1a9lWnDNwWoxmscpr4kY8HlY4n+E88?=
 =?us-ascii?Q?80dNUdsi17rToeaA8ay90HPlxNRj89aKcsc+5KTG11DAEAqnHzUfoVE+S4jv?=
 =?us-ascii?Q?BPPdfskD1at7SAENJmZt117Sb8REmvGsK6SW+aZ7sOP5UoV1HleyLxeWvXxe?=
 =?us-ascii?Q?3PBq2NjPGZOkHBY9eIaVTB/IjnD53YvYGeGPHChjT4xI/xXstsALXp13pBfM?=
 =?us-ascii?Q?N1rVRvP9GkIF0PRP56KTy1+7Ltznnqk=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 370929ad-5dfc-4b41-da64-08dede7fdbbe
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 12:36:26.3660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Mt/H3I3RUUkJd3oAV4lauaRm8HmheNRzDir/fA+CWNWuLwbzHS+oTy8W07uLSPIHt5TmRx/w9LVFLJEOM8C/zCHyIZhB+Sor/vgH7VCO9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6942
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

Currently, the ti-secure and ti-secure-rom types hardcode the contents
of the Distinguished Name section. Those values are not necessarily
appropriate for all boards that just happen to include a SOC produced
by TI.

Allow placing a distinguished-name subnode inside the binman node
representing the Entry_x509_cert (or derived classes), and if present,
use that information.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 tools/binman/etype/ti_secure.py     | 3 ++-
 tools/binman/etype/ti_secure_rom.py | 3 ++-
 tools/binman/etype/x509_cert.py     | 5 +++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index f6caa0286d9..0d8ade9b634 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -117,7 +117,8 @@ class Entry_ti_secure(Entry_x509_cert):
             self.firewall_cert_data['auth_in_place'] = auth_in_place
             self.ReadFirewallNode()
         self.sha = fdt_util.GetInt(self._node, 'sha', 512)
-        self.req_dist_name = {'C': 'US',
+        if self.req_dist_name is None:
+            self.req_dist_name = {'C': 'US',
                 'ST': 'TX',
                 'L': 'Dallas',
                 'O': 'Texas Instruments Incorporated',
diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
index 7e90c655940..ec49fa51739 100644
--- a/tools/binman/etype/ti_secure_rom.py
+++ b/tools/binman/etype/ti_secure_rom.py
@@ -80,7 +80,8 @@ class Entry_ti_secure_rom(Entry_x509_cert):
             self.dm_data = fdt_util.GetBool(self._node, 'dm-data', False)
             if self.dm_data:
                 self.load_addr_dm_data = fdt_util.GetInt(self._node, 'load-dm-data', 0x00000000)
-        self.req_dist_name = {'C': 'US',
+        if self.req_dist_name is None:
+            self.req_dist_name = {'C': 'US',
                     'ST': 'TX',
                     'L': 'Dallas',
                     'O': 'Texas Instruments Incorporated',
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb0..ee4c74db6f9 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -61,6 +61,11 @@ class Entry_x509_cert(Entry_collection):
         self.key_fname = self.GetEntryArgsOrProps([
             EntryArg('keyfile', str)], required=True)[0]
         self.sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
+        dist_name_node = self._node.FindNode('distinguished-name')
+        if dist_name_node:
+            self.req_dist_name = dict()
+            for pname, prop in dist_name_node.props.items():
+                self.req_dist_name[pname] = prop.value
 
     def GetCertificate(self, required, type='generic'):
         """Get the contents of this entry
-- 
2.55.0

