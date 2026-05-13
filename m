Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52818CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 08:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 217F3846AA;
	Wed, 13 May 2026 10:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="QJHEsRhF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39532836AC; Wed, 13 May 2026 10:04:02 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 093A98460E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI93Gh5pIaBFp3xMUk+Tprv0a2UGQxOdHF7gUg7kv1jyTTLjI8ktBegs+Yr+foT9BR7OevPWeyZyrWzo76vesdbqO4xE1THqtLPbYCXgsuOI3vIcU4jGW/oPDAiS55r6CGbQeR0uxHySFHbdrBIxmSH/tDZHKYew5kb5w0bV5HTkZuBfql2WuN9gtNlu+ERmxu0aHFsUYY7hZvDSC+nTd0cw+5uXRf0/zQmRNSZouKjmt2TmX8pW9eDM5KnlzuJrZa8a0uD98t8FxdgLBEHTGz9dF9fVBgX7NR3ytM5Bo7uExAlt/QXwOAw/UNw3Ne8SXfLZqUUEv8E5haNwY+leMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cSPQQRISRAYvF1ZvNqwK2Im8Pt2lnpBoVq/yKfM/oQ=;
 b=nckui6S6SQafyf+iZbzFnsAGQsQHbXRh6RfPTEG1k67xGAn32WMpCLhBN9DU5eCBqCuU4OdNR44rliV5I9+bQ2Oiw9M0wkkCjzIGaNaMAOqreX4i1/X1Z7VzF+3+6kWTzxtNur0UjrZEPjMp0wBvbk29eZzXefh4RZhCbodCgVocp4/Vy/fQ/GsV6uWrzHshYXS1BSUwtrBfVOebGNRgY5NscR75GX3pUKJreA8D/J9fyIGlqVwdjxTp+i7bB8NNrHqE8kYvRYHLFFNxQHT6CvcLqG7ypLDT7c3Nh6GqOrW4V9IR+PLMCNuAoa6xZxwgw+Ww0ffAkJnvMmwqWJFKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cSPQQRISRAYvF1ZvNqwK2Im8Pt2lnpBoVq/yKfM/oQ=;
 b=QJHEsRhFSkKjPfCK654MzTXVwa+IsRRoeBwkb8/ybYItieC5Nor0ZoAkUGI2HcryNKjW8+TkUHmICefxo4RV5ekPOGKRgWHZnvQi2nzJa1Www+dv8GNxEiah1e30urc4hgwTIsfG4clu9gPilLNhUUokV39aydn6ZIZpOQJKLhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AMBPR10MB9819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:725::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:03:55 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:03:55 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: <u-boot@lists.denx.de>,  Tom Rini <trini@konsulko.com>,  Simon Glass
 <sjg@chromium.org>
Subject: Re: [PATCH 0/2] allow control DTB to double as "FIT image"
In-Reply-To: <c6e0418e-9544-4553-a3d3-5f371b61233d@cherry.de> (Quentin
 Schulz's message of "Tue, 12 May 2026 18:39:52 +0200")
References: <20260512161631.284143-1-ravi@prevas.dk>
 <c6e0418e-9544-4553-a3d3-5f371b61233d@cherry.de>
Date: Wed, 13 May 2026 10:03:54 +0200
Message-ID: <871pffg2hh.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0009.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AMBPR10MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d878b5-0e99-41fd-7c72-08deb0c62dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|3023799003|11063799003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 1FS1OjJZ/2mGogULM2q8gwpb31aeJ8oNE9RkI0r737MEqLKcZ75e1/uyYZgVroMO5xsmTHwmtYT753YW6eL9hc6g/mRdoX4u2albIVW28QIDew4cc7wCzmzO4mAHlohdB65kcY/7z4uxDXVa6ld/N0ugUdzscQO9DxA58gKOHXbRpePs7hUbcBLOOm1g89qNb2KnwJ8BWkpy7m8Z1YXe2w9yRTavNAAxQWnOc3PVfR+4GnCSo8bN54LleeuRZNSzGb9cA2P6fm54+GWOj749ITX4pOjkryaKXWqOhH27gjeKI+jUBy7g8kR4tXtZfYKnyhqUNkjScX7E08+l3XLa3rJgebFjIhFT9/Ifsuh7CjuMJMVOy6P7K+8Z5OCtFdevRZHbKMoXXJEq+3/4HZbvrMotCPzuO6Txmn/vVTsL96/YzgWKYPamL8QffKc7vagaGiRmcNTRGDIOJ0THc7+oL6fA9wJGkWOzm7WCD+imt0GKyjWCydyISqruzLyk8uU1QrqXyO18upHfdcM1ZNECxDaXyK0otd/4/tn9cR0IQWjM6dYlTQLRoYYjuAnwFmh81tAeVVxpAywgJ/B6Owm4WP5ikzgB5tSCiR4iX1JBFbiodd62HIIVY5F/N/YKY7mJirM5QMUPfi62VwnhmWoK/TXyO1Hawx0LpfxyOs26kC+RcCXeAVVWVSSHMo0Cv8hsthMG1hZzX4B6CerLLEN8Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(3023799003)(11063799003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4pXdZMkmWAKJp2c1HnxGY0kpCF+ANOdd7yosdDZBcCH1W5hiInmuE+dX0JEY?=
 =?us-ascii?Q?EZ3rJO6IV8l88UZBS20i36q1hkcbwjHdDmFvsgdwK4oK6bMvRMR3JvFmvQrN?=
 =?us-ascii?Q?5KNraFWdGBtKxDey9PgHFeVAxgL0ThrZK2MSCN0Bcs4mTWVzQAvXCJgcGVxh?=
 =?us-ascii?Q?5iaNxqfhmVSK0WL3b1kru7cgHM3NyWV4SgEcDJj6ABy57M+ZObFV8c3SWVhb?=
 =?us-ascii?Q?rD+wexm3vMH2Z1ulnPAVA5+ymGJyfTK3mBMvhHyTE66SlOYrz2N/6zZ8Dp9y?=
 =?us-ascii?Q?f/XDANlGa2ukVN3GzF9rnFDZd+SoksOrzN+yvmuK9RayxYmPOWVPAAVzRKer?=
 =?us-ascii?Q?gva+ldaTLooDw+D6dwmhuzumJ4LPZevOkJ9SwuglrI2qnuk2oNcW64UCVR1z?=
 =?us-ascii?Q?K0z3CPcI+wWlGlZSbP4DVg8gQ28PCFNrDLsCJuYuuczz82yvEwvlB/qBMYId?=
 =?us-ascii?Q?PH5XVTlLGnqpXge2vtyd8C7SyEgkUhURgoXOe8h2uRNygaKdVCkmHelQkU1r?=
 =?us-ascii?Q?S/xfCnmlKXT5Z9D1geOeZxyB+2jYUtKqX/dcGQqdsJv2jsy2MTgX6CVOQzMl?=
 =?us-ascii?Q?sQ06DnmGO+j93hLBjT6jo7EOnckdXE1b+NfV8H9mW+yxShiZjU6heIBCJA2Z?=
 =?us-ascii?Q?B7pjNIZ7Gxvg51ux5fWIY8tpRT2SB0zFxd+H6O/hxbXntcx3a/GAH7RpvYwF?=
 =?us-ascii?Q?6E1I1mw2dAJjVFOhgnhpnon8FzqLha4Drxk1HDYm/bjONnq+DqaqwalV+psC?=
 =?us-ascii?Q?7e2jV1WKSxdZaTqep9m8AoZfzgbaoZqsq4W82HEyIF2tGPiNasC+Hpt6csmu?=
 =?us-ascii?Q?PA/bubxURtmdWJO2oE47UZ2Q2MO4s9YPVHvTIU8ss4lwl9+wKj6MtVzG5tcN?=
 =?us-ascii?Q?Y/T7mYvI5KvOYIyohzAThCdeJQZkHv/nSJ67uUi0T7DyAfEznDNI61FZ/H/9?=
 =?us-ascii?Q?hK9OQVT7FN18rJyfoImzh/MF97tK/kFtCjqt68XbiM5CsyQby6BWUxPGD0dn?=
 =?us-ascii?Q?eZ3sR/eLNhdGew6Qi/Tfi8zeUBvBrZHhmjfYU6nTCM0CEE4vhPTfdWMOPGo+?=
 =?us-ascii?Q?f5QPDuz/YCaC/NUyV+ziMBHrXh3rCVW1C5/vijQK9+oNrGIWemsIZRA/wbxn?=
 =?us-ascii?Q?TQKXwhLiIXA5R/wj5QypgH0YQbZD28mCaf0SzejbPBfT++u0R6qa1NQerpUL?=
 =?us-ascii?Q?1LxI34hM1kgBTULWSBRJFLYRTuhDGqWTwvIyAcsjKUOFV65/qdj4iUtIvSjg?=
 =?us-ascii?Q?FiN4jiWoBb6VHfTBjcIWKg6Kelg1JfqGylGWngKP2y+DBx8EclnrmIaOXQ+e?=
 =?us-ascii?Q?QhI/2HM+w/vAcZ2ITBWz3R17Uff5Fgi4cTlRj7RrV0Y5uOZnxzC0a6D4Frdr?=
 =?us-ascii?Q?3+g4Lg4FCoLW/zMbDA/MlkPP+/LtdPgxs4jXbPQOYZehcJpBxXFyShAEY11c?=
 =?us-ascii?Q?kkOh3vF2QjdnZZ6HGuXlbybdoOzpgfYsQ98AyLp/uKIuiSUccZfkXn3uzKPA?=
 =?us-ascii?Q?61DIjZktSI7qnLQ2PEf16MTWIUJTDFWMqJzKkh/Ra4d8q0UucvlIXfxApRLC?=
 =?us-ascii?Q?2X9Hc7Vz7A/KjwvNg6oCpCawbc9qtcts27zjLZ4nsDAJ0rhgosEr2c/zn2NH?=
 =?us-ascii?Q?CqHgfxw1C0vY9/oHJoQGVqfj0qOhKFLBEseLO3kw+fEks2rd0Z1arNe1Bcv/?=
 =?us-ascii?Q?JkW0vZsbGU+x4rzLJPFJq0AiUhOFLSIYLm2GZryYw775QuSnqqiycpwMdqGf?=
 =?us-ascii?Q?SboY45UwGpKXmw4vHlgI+Iqtx8XYr68=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d878b5-0e99-41fd-7c72-08deb0c62dfc
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:03:55.7136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m178q7Ztl0QjKgbjMSmPsFJMnjX1WOXdse+TP0J4Z1OeiKWTpDs5xxhjVLJofxejXEQV3KSOtSZulMiDH03YEm0pwuXuzfoZMU46hPibsgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9819
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

On Tue, May 12 2026, Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Rasmus,
>
> On 5/12/26 6:16 PM, Rasmus Villemoes wrote:
>> The commit message for patch 1 explains what it is I'd like to be able
>> to do, but here's some more background:
>> 
>
> For reference:
>
> """
> Writing those scripts in the built-in environment leads to
> backslatitis and missing or wrong quoting and is generally not very
> readable or maintainable.
> """
>
>
> Have you tried to use the text-based environment mechanism as
> described in
> https://docs.u-boot.org/en/latest/usage/environment.html#text-based-environment?
> (I've learned about this only very recently with the Apple devices
> being migrated to it)
>

Hi Quentin

Thanks for the suggestion. However, not only do I know about that
concept, I'm the author of f3d8f7dd73a ("Allow providing default
environment from file") which is a slightly different mechanism from the
one you refer to (and predates it by a few years), and which we've been
using ever since.

While both represent a definite improvement in the handling of the
_environment variables_ over definining it as a giant C string, it is
still not a very good way of writing whole scripts.

So the "text-based environment" method does allow you to (and
encouarages) indentation, but you don't get your editor's help to do the
if/while/... nesting properly because it's not a real script, and you
can't run shellcheck on those embedded snippets.

Moreover, while it _looks_ like a normal, commands-terminate-at-newline,
script, the stuff you put in those env variables must have all
individual commands terminated by a semicolon. Which to some extent
makes it even worse, because that is extremely easy to forget or
overlook. Imagine something like

   if something something ; then
      echo "yay";
      go_on_to_other_stuff;
   else
      echo "uh oh, something failed"                         <----
      handle_that_error;
   fi

Writing "scripts" in an env variable that can be called with "run foo"
is a bit like having to write normal shell scripts in a one-liner one
can pass to "sh -c '...'".

So no, I don't that's really a useful substitute for having a way to
properly embed real scripts in U-Boot.

Rasmus
