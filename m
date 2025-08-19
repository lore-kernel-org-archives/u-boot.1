Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C717CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 10:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD9680FA1;
	Tue, 19 Aug 2025 12:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="g7Y2CGD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE9882998; Tue, 19 Aug 2025 12:56:42 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27300802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qePYfgqEsp0JGVILjVonWqux1CYRPPPr8I9r0ijZC9tW5q7svfK7NN0dxdYK9Q4vupAHxHKDIDYJKZ3LRKXvkPCZ7WMfOnVb6sC605YlrnUNz3HdiiVaisGI6buFW44n2POEEi+Bc9Mk4p8MtY7Ig23HjSMFlfQWjpFc4wo+Hj2YcwV4OvWrUXfBooSqAC5jo8Vs3+3DKRj4zECeQNGOeTGaub+q+bXcDmOcCOClFI19W0keKGu9ypvZe7U0wzxxKnuhrafAkjgdDOk9yXmwJSgASevbqSoWpdgLjK6X/RP93GpnYO5aXf82gFnDDND6Zg6HyGspWZ3BTDTtN5vfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuP7YSL9SJVUQ6DLgAQqrV4CXuz/4tIL/Zb55jd7Tcc=;
 b=AlVpiizYL8ySeRODkPnqX8MUfKHKAhn4oOeNqP7mIbW9sW25kU36OBb8uS+6ItfGYCxzfWH/mrNUOC2tcMp1WVhB4fG7ipnR6R+EswvfokGzfWVgDgdMpQfKkCq27r9pUHl08oOA05S+qm7T2DfL+XejK4t291hTAVVwwfAjbu3UjRbrYvdORxPaUgojdT6XQluj6bA233WWZjVu603jyO95SSAAJxlvvl6nIC4VwgY7UNZp24LiYthxsl+O2AinKxonkc7SY3Bz3HgJNeu9bL7wY3cxyWp8gsfaq2ZA0Qytyo67eG2Ulho3fNt9hGI7b56c63/1BdxvHXvBbV8hkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuP7YSL9SJVUQ6DLgAQqrV4CXuz/4tIL/Zb55jd7Tcc=;
 b=g7Y2CGD6uqDqtyiKHctfBNfKhbpERn6h88JFr5ExcyPoV2CXfeSGoVAqsRgqSHjqu+Q9zVIvqojtQNDpkTvQGUpOU3eZ7VyKb240RDDmLYZlpA/qo+PyP2RGj2TDazeL2NYu1qStBbOod5agkaRiXMuv6jKaqJFSUMGGMKbZeWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB6156.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:56:37 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 10:56:36 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Sam Edwards <cfsworks@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] common/spl: use memmove() in load_simple_fit()
Date: Tue, 19 Aug 2025 12:55:54 +0200
Message-ID: <20250819105554.3067982-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 343cf168-f418-4326-07a2-08dddf0f1172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PgScZJS08WG5Na+I6SL3F0cYgJoT4xnR2beugxAIM15qAeQjuv6nnD/f+Tq9?=
 =?us-ascii?Q?/NvgOf/CfbZWetNp+y/MshOFC3vpZiy6yH7YSPYG8XuksO6s/Nd8qoeU+i17?=
 =?us-ascii?Q?AxjZgLzV4H/YfGXcWapPH1HPDqJWEB1md8VCxlCe5BImARd0k6h0M0XHpgXw?=
 =?us-ascii?Q?TgXBCGiqg9KhXOtLDYICEssNdDFWxUeGCN0ZEdGHS9c7/yg7h2kR8gcYhNvt?=
 =?us-ascii?Q?ss+qK64rXy0xBPbxUGFTqsNLGepNIUB+nqxr0Tk9ruyKR8geS2W+ZAxkd9yy?=
 =?us-ascii?Q?NUV9v73lMsU4u4BPF1Lko0T5nfSTbUCyu4+PJ6RJCqE1Zi1ujUtTa/Y3xreC?=
 =?us-ascii?Q?8T+xRyxMbMU5r1CdXb6zHcPJOXSHaSReHeOPIOOJTGZX3Jl894NJQf+2JJWC?=
 =?us-ascii?Q?LFYeOMeI/I/TfZcs8ErIOJmHlqNME/6PHrS5+Xn/uvgLC212S9dbE6GoEi89?=
 =?us-ascii?Q?Phh2vQNmOLReLuiSQ80RUtEKAMjM8wRj7z+3NpyRlyC+bxuTshg0VNIqcG8l?=
 =?us-ascii?Q?aF8g3JxbXl665p9C05U6NrUOjtFA/MCgfQTmok3WRQkcgDlYDlI1TRliT2fZ?=
 =?us-ascii?Q?KBrbEyMqk5C60SDnOidcSxSbxSnYaA3FpuNh09C3t8TWH7aJjBUJo4rFyMPC?=
 =?us-ascii?Q?CafI1vvipzCFr8mK143ajJuqK4r0bKfNmQ5pA8meHMVQEJLQPgWWb5Nvw0As?=
 =?us-ascii?Q?afYc3ijAl8jUXeiUu0sENaDhKjX8M4iZP6sQ9kfm93ihgFJd2T3FAa9sIP9R?=
 =?us-ascii?Q?uWX02ha2Za6OhktP2SjzgwkMZIJ1Cn6nAGg2b4Ee34vlivM2S3b7q3Y/XODV?=
 =?us-ascii?Q?EgrURVMOQq1ahddv0pUtg1KDYL6EmkPAVZbca7oyFF2BGqhzbOdlwyl3qJDx?=
 =?us-ascii?Q?RaYjHaGv6iUPHaMKspxLwtUTjzkcK5ManAmB0frauEBSIWiaNiQKNtgM8Kyx?=
 =?us-ascii?Q?qzHv6lrSkqU5hDzeELXCDb6JRfWv8vRYf4W8iEemvwaeZSgZvSbmDq9ZA8GD?=
 =?us-ascii?Q?y7/jkmkPGU8L2O/IwBE4WImqyIqPOS4VAQuRoWOlxk/PgJ0E6A6EpnXFfuZs?=
 =?us-ascii?Q?XzW5uYM+pRixAZ89cKQGZj7y9h2k+BxFMgThDLQu0WNqUYUSckLDVJmEXAuE?=
 =?us-ascii?Q?OxoxV8HT35yCko+/3Dmhvh5H7rfILE6GhpyU5aqdOKdU259a34Uoc8iso3DO?=
 =?us-ascii?Q?tuODCebkAmYo4HlnNaXm6jCvQL5DcZ03dNxVrXMIHpEqcwQz6YpkJ+q4fQM3?=
 =?us-ascii?Q?VTRNAKWFhjtn84gwokbJdef2kBHsALvO/aAkYi25j8RGTigJnwI4FiZMXeDT?=
 =?us-ascii?Q?xTQoDzzmtikPzLBFjFY62ZNxS2exSzn3iegp9r60fYl12WEUfBK4VP6TXh3y?=
 =?us-ascii?Q?J0oeLPeIy2THg/o88bSUg4fQKEJgsPXW7uwLLBnfwysChg05+4tBSoI2Wk6z?=
 =?us-ascii?Q?eCjoZUdEqXXXpgI0pju4qm6kUSFGW3eygPINmwPpal6h+UbuxqZ7Jw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VKyV3uORBi0J0Ni+PlIM5pfjXKZmVgLrTC5AuIcWmvxKo98/wK4z6b+sM/SP?=
 =?us-ascii?Q?vKid7G1PDELouu1VL/saPaHIAug1paATfZ91glSXp/wC2/skNg09lF56QXib?=
 =?us-ascii?Q?u4hE1t0vfvuTfU6mVIEacHR+Kes0q8QujWzV+7zvZI6R2r3c8YaqwGZ3i7sm?=
 =?us-ascii?Q?NDu8LYxrBTcSoqNcNXe4XPrBHB8ArylLXZX9NoiPh2c1TATQqolzfk2/T48d?=
 =?us-ascii?Q?4MQLXY8nlipMQXy6PirRo0L/k2aH6mht7qWSFczTD+EOZe2gDEkA6J6kFB9J?=
 =?us-ascii?Q?pjlC5itiFZLKuA5NpAgkBw192apEwPMWNEIEBwMlm50ghbsZqDrUWTzmW5Hi?=
 =?us-ascii?Q?WbuA62CArcZ/GN2koliktY8dzKcc4PpdHDbvhDbb/IlDVZtYhhCE83oUl+O8?=
 =?us-ascii?Q?xm1XNk7n/WWkL7Flo3caTOkReStCNT9i8Z5T5q5TcAWwPjeY8TO9p4TuWPhx?=
 =?us-ascii?Q?4mTojuX0Tb3hhu21nCtB41eMQjVqu+yBfoRq0dowdWWdMUt+u6WfBpPoQQuD?=
 =?us-ascii?Q?fQmlUdeLBxkbdr9bEDIL66CguofT4HID2uaoykFI7e4qc9r29ojMtyTQqC79?=
 =?us-ascii?Q?oSSVcHe7hao4yL3RxgHTrhaU0xVlY4w3vsFaQh8TLOk3mhpWXpUjX7XJPreE?=
 =?us-ascii?Q?e41IxBYM5M1Oe5h+R7bQBpWzosa7oklTowuXk+FS0vm2tRs8JM0Rak3t4zKl?=
 =?us-ascii?Q?T7YQpFS17SgLIh8VGE5LGhMfFrVVOfD5QiwQhE5k/dL53Z4lI6L+OrdHpGOE?=
 =?us-ascii?Q?13NC+8hJdZI5qWt/FGDRfyyWl1IXfgJ7T3RzKkV631duN23sRr0UebWl4XBg?=
 =?us-ascii?Q?DemIlurrCAvU7DcSdjaeHrV+RBUvk5uSTe7fA3YYPDogeIsM5qGWoNf5UdJs?=
 =?us-ascii?Q?ZpiTUqMMwg7VIYfrbInBewn7OUrWpDLmm5h8I6pmh4uE1KBdWP19QcbQ31o6?=
 =?us-ascii?Q?O+PLhi7P8JChXIbhNfLAO7R8l+PEVh+GWqLObv34gDCHQA0Cqq0EMmtZTx12?=
 =?us-ascii?Q?mZg6xXTIV3Q7b8JhJq5NYb8s8OWuu2inwCdzKS/wi0xIjfcxeLdsnRY/QUxr?=
 =?us-ascii?Q?/uiKngPJShyKcfi4JLDLl6K9GzYztqFehtml3w5Mp4WONz9pPKTO3phgq29n?=
 =?us-ascii?Q?atPOnkwos3vaPGDnAQMqe1XM+BKS2TNKKd5q2hd54RRgr+mTvZGFKUAirOXo?=
 =?us-ascii?Q?DWQyeKrGX39K7buMvaQHL/OYRv1j3Kj4iJN3SkjmCeXHWJmK0C/zG/Q+O1U4?=
 =?us-ascii?Q?5R2XnBklqy6oyhLaOh7rrHk5ScHdm0L/+JGK/gK+dKtf0pJm/wcntCg+lf9B?=
 =?us-ascii?Q?TR7cw2ClYmsu3356Hal/00+F2ANH9fJ/dtv1uxsOlE4+KZwha21Fn36+mjtE?=
 =?us-ascii?Q?peuRaJouwL0xmQtIDOwfRGIe5jJItlpwEvToWVvYhgzBGjvWNamQ3/fLWuZn?=
 =?us-ascii?Q?fmuCr2Ltk1qt77gH7C+4fT0eM/Uul1+f5f6xCrsjWx4jaSGAtRgcgQB2Sagc?=
 =?us-ascii?Q?QPx5AoD6tQXnZyeyfbONAiMxq9Z8m9Ba+ommMlZDjkhcObbo1s2D+6MWdcQk?=
 =?us-ascii?Q?UzE1wsqWrrUg5kRetqoXz8rpKj2Ry3p2RgUXqbR1mtijl43cvaSHs8KeAmtP?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 343cf168-f418-4326-07a2-08dddf0f1172
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 10:56:36.8198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLwlt/5U4WiwqJW2mK3CH9dLoQHf71mdp0ZOHB0HlSAyM+oJSqtvfKWkr+7PGysliJhaYPac2/HGKyJ7dhT08zBC0ulkj1fjYqdrljyMiHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6156
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

I had trouble booting some am335x boards (both
beagleboneblack and a custom board). SPL would start just fine, and
apparently load U-Boot proper, but it would hang when jumping to
U-Boot.

While debugging, I stumbled on this memcpy() which from code
inspection very much looked to have overlapping src and dst, and
indeed a simple printf revealed

  calling memcpy(0x8087bf68, 0x8087bf80, 0xf7f8)

Now, it will always be with src > dst, our memcpy()
implementations "most likely" do forward-copying, and in the end it
turned out that this wasn't the culprit after all [*].

But to avoid me or others barking up the wrong tree in the future, and
because this use of memcpy() is technically undefined, use memmove()
instead.

[*] That was 358d1cc232c ("spl: Align FDT load address"), which has
since been fixed in master but not the v2025.07 I worked of by
52caad0d14a ("ARM: Align image end to 8 bytes to fit DT alignment").

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 common/spl/spl_fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 25f3c822a49..746c3d2fa28 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -353,7 +353,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		}
 		length = loadEnd - CONFIG_SYS_LOAD_ADDR;
 	} else {
-		memcpy(load_ptr, src, length);
+		memmove(load_ptr, src, length);
 	}
 
 	if (image_info) {
-- 
2.50.1

