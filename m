Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D637DCDB482
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 13:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2307286ECA;
	Tue, 17 Oct 2023 15:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="iClutKhx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F34B586EE0; Tue, 17 Oct 2023 15:29:41 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::721])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F360F86ECA
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 15:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRqbjxyfpYL+0fBjiUY/lMGkIVaQ8Z2m5Q/SpBiUXMpDbubzWwWeAH7sOwOweW/HRcO/YoATeIQcIV1IhaQvYLcdh7Q4sZ/vK9H51x9ro9aqwCSr979wJBRaSLv3rWRT5MM89fkBiZZjjtAHBWF8xra7aEb/iVNNuQUMWAM+W0o+IyJGEAuZB+FfnNmtnhDZZBtpcsWcd0l6gVCvFp4aTNxsfpy/UsMoFfkXPEY2BuL5zvgW0/k5ZnzB/FZ01oPCBhLSrYwudMhHgkPXMzActga6MtURJK9WgxvhmrplfQBA/q/NiRDt7+ZQz5Gp/Z9QsvSyedFrpospouEvSbX7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCLn62V8KqL1x00Rsom3t+KcXyybU/me3riA1DIUD9A=;
 b=EhJeEUOa/L/s0PVtHkC7OgofT8o70gi5YfCWQeh8ylXols2oRXhK+9OBVz1bdH6j0SgEqgNfS28yHaGLwU2xvJFi50RhoZ3Q+aBPsctjZIbAbmff5ukSjnCoqs2dc+livTFBpLXyEBk7xv7i69JKDpTOzaBf4YOHNFyRlrpqUwcMDchNJZfpwQvueS29lzkQHNbVdgJEbajWPr5G0dZfba0jgijPOkXRFhxjTseqTzgXeWGqa6fTGz8mJ6IkI7Bb8FFjrY1uOMTEEqxcIK66l+my2pUbax07IHDJnpqdUkTOJmaBMABwL69cUR/leYYDF070187rLB0gk1YKHOBchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCLn62V8KqL1x00Rsom3t+KcXyybU/me3riA1DIUD9A=;
 b=iClutKhx9AsKPAMnITA/589c04VOSAcPKvrBmCGEBupIL8Y+ImhM/+jbZKVvwA1zYPcDZLtKj0JHXi1HiB8NNTaRmm4el8dv1AHg5wl4kJycF46PRfYEmAhO/TlngmBcalyt0hCffhPG3QdqplhDyE/mLIW33TpNH+NtrqhErK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB5600.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 13:29:37 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 13:29:37 +0000
Message-ID: <d588fefd-45ec-4642-bf6d-73fcc652591d@prevas.dk>
Date: Tue, 17 Oct 2023 15:29:35 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US, da
To: u-boot <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: commit 83c63f0d118 (led: Move OF "label" property parsing to core)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a76225-e629-4565-d6d8-08dbcf151bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+jQ2ilVAoj30HysSoz+78rOEOva/rgs5MPOcCHMUUoYF9PCVzmZguOJrBCmouaMZ3fhj6HlsVd/Ch2HmlSx0NM0roErGUajLQmc2U+huO21mpnRmGjrB94xSkgrAYwgevgR2oWJYgxMkcmaamTjjSCmJGGDipcffuiN8sRbgaXuKddVRVsY5iA7pXd18hb7fdWuAZ9mwpWZFCXxjmYUoMlK2Jjh2aSelIm0E93k/34GVrLwp/rby1/LrLwS2QJuf00mdsrFjbFaboQKg/BMMp4xh8Vqk99naIQh63GX2ZW5Dur6qmPOxHcAABxfdya0rAbT1iCmfHK/q/PaBP++1Rl2E1DeURFshupg+laKy3y77r9a1T6biQd13sJDM3UfH6vdKdfXKP9uj+VnTmrC6lGMK3Ur79A/SMoltNvva6mLWX8RPGv3eKpY0fiHWe/iaz9XZT7U8Qk8p4FxTM5Y3bhLOboAmHh/smx3Dvp0FgpxksdJNcH61X9FCt52RqX9erdpcWxMvU08nUlabU5AxAjLtHPVspbLqbRhWlCLxpkQgWNcVPmPD/AHXr6IywXXyly/fuDlCdkxBNXPKb9rOwm/qp4QdcFvoIBzDk5yYMiORAkdvgTmH/nZIp0pZMdjc4KNYCVr88xUPAAC17V9bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(39850400004)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(41300700001)(66556008)(66476007)(66946007)(478600001)(54906003)(6486002)(6916009)(6506007)(26005)(316002)(6512007)(2616005)(5660300002)(4326008)(8676002)(8976002)(8936002)(2906002)(44832011)(36756003)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djd6ZHhsY09tRFZUeVBMQU8rNVV5V2FCazdTazF2U1dZMW5aQ3pOWG5qbUcz?=
 =?utf-8?B?dGZDWmNhSk03OXRPZ2xKUzY2YXNjN1pzaXNHQklXa1E4WXovSStxUVBvLzhO?=
 =?utf-8?B?cXBzZHpyc1c3VW8rbUpxdDZiVnBGVCtoQjRJbG1kR0doek5IUUhVdm5uckRG?=
 =?utf-8?B?RFFjYmFzUFU5TUF2a3g3ekNnTm40Rmw3YlFrUnh0UnhNQUNrc2s5RURCQ2tu?=
 =?utf-8?B?L2U1RlIrbzFaNmFmSy9mcDRUbEVqWHZOYUkzajNOSG1BbUREWENtSUhkcU4y?=
 =?utf-8?B?TnZtMnlPZVIzRWx4S0xOZW55bk1zUjZzTkJENXorSmswSGxyZDF6NkJUdUJI?=
 =?utf-8?B?Ly95RDFOcFd2YUdoemlnMnhVN3l2TlgwRG5QN01XUnUxQkR0TUFoVXhXNFRj?=
 =?utf-8?B?ZzZFUFdBUjFmc3FGdExVMXphY0xYSkh0SU9GVUR0Z3h6bjFxMW5CNnptcWxM?=
 =?utf-8?B?WFE3UnB6MFQ2Wld4ZU95aktBa09yN01oZHpSZkpNZW1lMWNaS0Rpa0V3WDZJ?=
 =?utf-8?B?MC9aT25kRVVLTmt2Yk1BbUNjcVNiajhtTzRoTVpCdGVubUpHYWQ1SGhUUlBN?=
 =?utf-8?B?WEVmSUZLc3ovbkhqZnVWdXJtWElkSGdNS2pqUDZjVlJURUlzRHk5bGZVTEdX?=
 =?utf-8?B?R2RwT3BhVkR1SEVqWXBBMnM5NUtMNVJqem9LcTRqVm8wcU5BN2pwNnZmT0N6?=
 =?utf-8?B?WkVYK3VUZGZWWWJBL1V0VEwycjJlNCtoWDhQVFB4VUNVbklFZVJtL2JYVmZs?=
 =?utf-8?B?dVV6bTRPd0dPeUpPbkM1T0JrY2poSDhNS1Q0cVNYUndQREN1Yi8rVkVKM2l3?=
 =?utf-8?B?QWVsWm1WNjU3VXNPbElNOWNPS0htV3l6TEdNQmVQL3NUd05XNTRwYVJXSUx4?=
 =?utf-8?B?UUZpbit4RlQ3Q0pEY0p1YWdBQlZhbjJVZDhsRUoyNjZNMnZ1RFB6c295a2xG?=
 =?utf-8?B?enhyVWVIRHg4SVhLUXdXVVk3Q3RaS1ZjNTRyWkhyQ3NOYWZISFRNcXNtL0d0?=
 =?utf-8?B?SzR3bGRWa3hHaVhBOFNuME9GY2FyS05oOGhVTzBLcWZsNGk3SkluWVdRcTQz?=
 =?utf-8?B?UzNGMHZaajdMTWNaNmNlbWF2dE50MVZtb2RzY0E3M2xyd0hoOURaTUxBbTZP?=
 =?utf-8?B?MmhnQmRBaWN5YmdPemxaVlJyMHJ1WkZtMktId1N1Sng2dzVXTnJ6d2dYWkha?=
 =?utf-8?B?KzNucmNxdDEvOVRFQkQvTjlZekJuZVBKUWw1aU9XK2ozNWU4NGlZejVIdlhx?=
 =?utf-8?B?c09pWkMyM2lCN25EK29wQWllUnA0SVJ0VXd6b1liNmFiTnFBREo0ZU5BdGVM?=
 =?utf-8?B?MGhSbUVHK3c2ZFBaWmlUN3hnUW5KMm9NUzdXRWN4Z2diRVkza3ZRS2drMDJl?=
 =?utf-8?B?SjNBVmFROEdTblhDM1hCVWIvRVJla2psOG0vcXBtcC9ZWEdYMFNTVXBmSThn?=
 =?utf-8?B?aDc3U2FYZ2pOZHBpWkNibC9lNWdUVEtmNVcxM0x2ZDNuVWVsUjluSE81WWJt?=
 =?utf-8?B?NzRRSWNBN0lWa2VCSHl2ajNrWndCMW9ZUzlldGlnNklQRzlWdHVTeDZ4aFdH?=
 =?utf-8?B?OENzWm8vUndOdG8zMkNabVROVHdndXR5SUVKWHFKOTRJenBhekppQk5sL2tB?=
 =?utf-8?B?SERTZWppZVlHWUdGYnRtNUxZcXpvekdVOXArZEg0NkVuR0o4U2gxT3FrKzdX?=
 =?utf-8?B?QTZRZjRUb1RiWTJRaXBmaFlkQXBJczNnMlQ2cW5NOVNkVVBnWG1UZWxEZ1ds?=
 =?utf-8?B?VklBWEFlcmwyVElEa1pWTmlrTGp4OHozTCtpVHBmY1FnQTNjMkpwK1Nqd1BF?=
 =?utf-8?B?dWFOdFZlc0c5MXgxZXN4NFlUR3JnbERqMTF6OW1BVjJzRTNoTHhselBpN2dm?=
 =?utf-8?B?TUREQloxRGJDVTIwOXZudncrY0Z1cGR0blk5Y1VseDdFdWVzbm9OUmRCc3M0?=
 =?utf-8?B?V3RkSUw4VjA0WTAyMzV1ei9VN3BrZGFpK29GV1F1aFpVMXFWZ0orbWlPbDI0?=
 =?utf-8?B?eUZKdmhQQXF4OENOMDZsUWx4SmpDYXFVYkE2b1dCbWhON0Q5QUdBQkhkMndQ?=
 =?utf-8?B?OElDbUFHRm1nOXZZaWRJYi9IYWNhV0l4VXNtSlN5Y2hZdEJGelJpcFJjdlBa?=
 =?utf-8?B?WDFwR3RXRUpSVlRhL1JQcnFWOGxQeUZLSDR5SUVXWngzRmwrenV4NllUKzEw?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a76225-e629-4565-d6d8-08dbcf151bf6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 13:29:37.4755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K3eLySdObUtdC3XwAFohsIJxxVvGY96KWtZCOfO3XIUqnBkwqojG/BXMdTY5ZGd6K5MX7/gh3LCoQBlxg6Gltr/t71EOrKnEdzqhOyq7+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5600
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

Hi,

I'm trying to resurrect an old submission of a driver for ti,lp5562, so
had occasion to dig into drivers/led/. And I think commit 83c63f0d118 is
buggy or at least incomplete.

Many of the drivers that were subsequently modified to not do that
"label" parsing rely, in their .probe method, on the top node being
distinguished by not having a ->label. And led-uclass itself does that

                /* Ignore the top-level LED node */
                if (uc_plat->label && !strcmp(label, uc_plat->label))
                        return uclass_get_device_tail(dev, 0, devp);

The drivers used to only do that label-parsing for subnodes of the top
node, so that worked, but the new code assigns some ->label for anything
bound to a LED uclass driver. There have been at least two patches to
individual drivers to fix this up since (the current top two patches
touching drivers/led/), but I think that's the wrong way to handle this.

At the same time, I actually think 83c63f0d118 didn't go far enough in
deduplicating, since all drivers are left with essentially the same loop:

static int led_gpio_bind(struct udevice *parent)
{
	struct udevice *dev;
	ofnode node;
	int ret;

	dev_for_each_subnode(node, parent) {
		ret = device_bind_driver_to_node(parent, "gpio_led",
						 ofnode_get_name(node),
						 node, &dev);
		if (ret)
			return ret;
	}

	return 0;
}

static int bcm6753_led_bind(struct udevice *parent)
{
	ofnode node;

	dev_for_each_subnode(node, parent) {
		struct udevice *dev;
		int ret;

		ret = device_bind_driver_to_node(parent, "bcm6753-led",
						 ofnode_get_name(node),
						 node, &dev);
		if (ret)
			return ret;
	}

	return 0;
}

and that string can, if I'm not mistaken, be gotten from
parent->driver->name. So we really should be able to create a
generic_led_bind() that does exactly this loop + the "label" parsing,
remove the label parsing from post_bind (so it doesn't apply to the top
nodes), and switch all drivers over to this generic_led_bind().

Alternatively, we can still create a generic_led_bind() that just does
the loop as above, but then somehow prevent the top nodes from gaining
->label, say by not adding the nodename fallback if the node has a
"compatible" property (though that seems like a hack, maybe there's a
cleaner way).

WDYT?

Rasmus

