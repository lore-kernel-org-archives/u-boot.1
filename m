Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88758606A327
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QeBx/cTa;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=mrk4+eNe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A68F608C9;
	Thu, 26 Nov 2026 09:56:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 36O_MIKnIiuz; Thu, 26 Nov 2026 09:56:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7FF0460799
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795686996;
	b=q9HTcb465ZV3CvwEJEi1FC9LAfJ7usLuyL0NDppnynrX4I/0BBkLfispXjD+CscsEgS5
	 kAuUnlOHZu6Xd0lvwIjOau9R0UYb0vdM37PRLs76mbhN3RjJpKiSavwXI3GFtEDH5wkok
	 GPaD9u9/jJdJcf3LerfmTZZYHE7XZyfw94CTZEpIx/c5TMA1TBmjCzt0ap+45VrkEy2dx
	 AaXrLXyJG5Ap9linVFPcUXC4d2UaW1ehZBD3ZE4HXpmNVVhqDH8yJE77ZrFnGwyD3nVvG
	 mo9zPtcnoIQ3eB4d3f9pRAqu+dGmnR2u+7ilDQuBO6YAatW6sm0VDAX9BfXzD4u07lQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795686996;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dv01+JAXKKqQ0Q8n5YQHkUL3R+iWxGV9XuIhHamBX6M=;
	b=GA5qyukRnnKEztRYsGJ+Q067x2dNwmu9Fh5CMkKknPArN9kX6GxTe66zxRyQd2PYGIFb
	 T2aQDKl13cQiShSagNXmYsJMx7gjTY7qauqXnGJCxiphbP81CVmk3K4jTdJuAqohxMEX6
	 DZmjc/fGxH4Hdp1qxF/VD3cXhlhA1rK+sis2ByPoGVhD7mIDcNcCnyRiXnNWNg9/xoCvg
	 5IZSVAOxOZwDO+ZFckxYjZfDjVEI8nz/2qxGV/GQ5OdGB55VHB6I84T6bt4uWvjI8OpjT
	 HZEuzvKKro1YuFejLquAOjqkque/np7hOoXxhEKpuhgZGHAcxIIjjEu7BeiUiUIm4Pw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795686996;
	bh=dv01+JAXKKqQ0Q8n5YQHkUL3R+iWxGV9XuIhHamBX6M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QeBx/cTarMNKfL0hI/5cNzQ71STFx86ziyEIdVkRU1+cai5O57m+QVpdHO4XLdzzr
	 ACzz6+7NzoAYgk8ZrrNgkpqk4/mfx7FDm8qN7NVi640jbDe6aw0BL7pfMXQ4m3XLtn
	 v8m0hl6rRyQgG0xQMLpWCkH18/2ku8XHJJBs53UevsNOro8IKjCyZF6/eN5/ZpkEFz
	 tQx7xY1QVUu54G1YmAYsY5GKUrJ0yFyx4MV3JufMo0A9NRGg6/j2gGKh+ScZFi0cVi
	 eYAlr4Ts00alXyXaf2niIEy/KjG/1wFQmlO7W5sRA3D/7aY/xMOhqA4evZEDxdC5H9
	 j/D+ApTzEMhqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FF0460799;
	Thu, 26 Nov 2026 09:56:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94C27325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8545B4087E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:56:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lhB50XnB8n5c for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 09:56:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A7374086F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=mrk4+eNe
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A7374086F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dv01+JAXKKqQ0Q8n5YQHkUL3R+iWxGV9XuIhHamBX6M=;
 b=mrk4+eNesW0bspLQj75+jDC+vmDLcO5t+dZfAAeTdEPmITOq/o4eV35YNKKQdB0dW/BzRI9Z/yTxAaLmLVtLvP9i0fBahK1UUXGmWSI3SEE1TtQzhKzXbyKcRrt22wSCczecQN3WmkIVpxH+x4G7Gvs/B2+jCYWPk1NAP+jGDb9hMLA20uR7ZSCVIvUMLjV8L0qJGQEQ5coOwIeS7sClqk+63w7bR7jv6JdShL9mBIKlVydvzWTE6UHQabM8KVgr+Hum3lo+/ZYZu+CXYzftsotupFEOTgWB464CrzVrNu95fhZxErtwC2S7NWQwQmGy/zzIFnfk2sau8QOhTJVXQw==
Received: from FR5P281CA0043.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:f3::14)
 by PAVPR10MB7539.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Thu, 26 Nov
 2026 09:56:25 +0000
Received: from MI3PEPF00008488.eurprd02.prod.outlook.com
 (2603:10a6:d10:f3:cafe::5a) by FR5P281CA0043.outlook.office365.com
 (2603:10a6:d10:f3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5 via Frontend Transport; Thu, 26
 Nov 2026 09:56:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008488.mail.protection.outlook.com (10.167.240.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 09:56:24 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 10:57:30 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 10:56:24 +0100
Message-ID: <2110b84d-a5e2-477f-a3e6-2d1fcf010faa@foss.st.com>
Date: Thu, 26 Nov 2026 10:56:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: fwumdata: fix redundant metadata buffer overlap
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>
References: <20261119-fix_tools_fwumdata-v2-1-ce6c95f40988@foss.st.com>
 <CAC_iWjKN+2igM5J2a+_n9muSPDWixaF28oWGtun8JOnWiJu_6Q@mail.gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAC_iWjKN+2igM5J2a+_n9muSPDWixaF28oWGtun8JOnWiJu_6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008488:EE_|PAVPR10MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 372d53c7-7037-4079-ff4c-08df4ba3884e
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|261102123227099003|10067099003|56012099006|11063799006|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261009223027099003|22082099003|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: uQb1nTZEGWc5QOlvcynCRSWDZrLxsXi3tsJ4kb5dOq/UMXv6fl1b9ujiTloEVWaKOYAuxPdVBTe2TmPqKPKFPJUSOTfgKlIi/QZ4QeEIB8i8ZBXTxk0l1KwhA8B93ToV13qYE2chBn0rAZNEqwACdShMXOFfhc0pKBqotogl/Mx0WJRqJ3KdM7JdJl0R2ZW45QFvE7SGBc3Rl35OkUhg0fs6NOq49939doXZgX6hAZgAIej3dztj2XUX26Ttb0bI+ptkS88zVhNknbvGBtgOXooP1jCcTMRaqWPZAaXdqLL8VG84C4gYxpsKNsp1rcqkNWc8Dq7VfExc5zcljSD1uOZOi5nQmuc0M7STv5qjc42Z25VW1dJ+MeoKpkKeucv+QLLP4YFxrjp7KwkOu0Xkqn5xAuCr2n24sQ3MXM2RGLTzbi/y+thFTrj77EOJsgcnGRAfgwmJQFpYVKY6oMJ159jS4OYTsvt0M9pbiFF1hxxVtOpnEaWA6d9waMBYV5VLHjOdBqJeDiM9Sma5i1ZAwKBfccv4MswHiDAyhIf/tDq30znSUKtO7YVY/tOOp6bhjP4TSorrXwdUgFXt4qpE//rEkhwJxnySQ4Rur5mukewQHzaNeQC3wmrdiQt9yuwLGqrZBzi3i1nXeaUyVgPPloJNDPNJS7RspC1Dgb4v5z4W7LCx5E5JE2C/pZlpJpDjANMAMggGWo1Z7FolQ8FDKw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(261102123227099003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ei7qBgLwHpj9bEKOoObPPOkW8OacyUDtz++8Y6kzSCWsrJMdkdhQ5K/jgdwP5ECbW0bdZU3KVyLdVASmUswLVjVo4bSZRAli1PBAL8szKcLkc4PB7BK2F87xBNFP3u9tM39/vTOj6xarFdLTxypRB+NhPupLJVR9HlgfO7SbJcIqi+O5G9VbRxjP0/NwVK1NaCeAeaoWZNHbPRtl9bqhDjBRZP7NXi6vapiyJgiv76e7eHyjFJs/6wwbSo/LzPo2dd6fG9bih7+h7dI12OEKt1569AuMIIduK+cwyg2J0w5bgl7sVbUO2rbglkruV0Oa1p/sFIz45ZOHnvQmOp8xIxQ3PT2Yhm4Nhc/5LXKsS6o0L24A3G5yG/L+SkqBcR7zL7TTY1DcuqcsXZ2SqChOUcOpq5ebfHcVctRjiFava2FIZWtu1+LdDGenQNXc+HCB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:56:24.8110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372d53c7-7037-4079-ff4c-08df4ba3884e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008488.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7539
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/26/26 08:46, Ilias Apalodimas wrote:
> Hi Patric
> 
> 
>> + * Return a pointer to metadata copy @id inside the contiguous buffer.
>> + * Copies are laid out mdata_size bytes apart, which is not the same as
>> + * sizeof(struct fwu_mdata): the latter only covers the common header, so
>> + * indexing mdata as an array of struct fwu_mdata would make the copies
>> + * overlap. Both copies are guaranteed to share the same size (checked in
>> + * parse_config()).
>> + */
>> +static struct fwu_mdata *mdata_copy(int id)
>> +{
>> +       return (struct fwu_mdata *)((u8 *)mdata + id * devices[0].mdata_size);
>> +}
> 
> The patch seems correct, but the naming here is confusing. This is not
> copying anything, it just returns a ptr to the correct mdata offset.
> So perhaps mdata_get_copy()?
> 
> With that
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Hi Ilias

OK i will rename mdata_copy() to mdata_get_copy()

Thanks
Patrice

>> +
>>  static int read_one_metadata(int mdata_id, size_t size)
>>  {
>> +       struct fwu_mdata *md = mdata_copy(mdata_id);
>>         int ret;
>>
>>         ret = open_device(&devices[mdata_id]);
>>         if (ret)
>>                 return ret;
>>
>> -       ret = read_device(&devices[mdata_id], &mdata[mdata_id], size);
>> +       ret = read_device(&devices[mdata_id], md, size);
>>         if (ret)
>>                 return ret;
>>
>> -       if (mdata[mdata_id].version != 1 && mdata[mdata_id].version != 2) {
>> +       if (md->version != 1 && md->version != 2) {
>>                 fprintf(stderr, "Invalid metadata %d version: %u\n",
>> -                       mdata_id, mdata[mdata_id].version);
>> +                       mdata_id, md->version);
>>         }
>>
>>         return 0;
>> @@ -283,12 +297,12 @@ static int read_metadata(bool update)
>>         if (ret)
>>                 return ret;
>>
>> -       if (validate_crc(&mdata[0], alloc_size) < 0) {
>> +       if (validate_crc(mdata_copy(0), alloc_size) < 0) {
>>                 fprintf(stderr,
>>                         "Warning: Primary metadata CRC validation failed\n");
>>                 mdata_mod = update;
>>         } else {
>> -               valid_mdata = &mdata[0];
>> +               valid_mdata = mdata_copy(0);
>>         }
>>
>>         if (have_redundant) {
>> @@ -296,16 +310,17 @@ static int read_metadata(bool update)
>>                 if (ret)
>>                         return ret;
>>
>> -               if (validate_crc(&mdata[1], alloc_size) < 0) {
>> +               if (validate_crc(mdata_copy(1), alloc_size) < 0) {
>>                         fprintf(stderr,
>>                                 "Warning: Secondary metadata CRC validation failed\n");
>>                         mdata_mod = update;
>> -               } else if (valid_mdata && mdata[0].crc32 != mdata[1].crc32) {
>> +               } else if (valid_mdata &&
>> +                          mdata_copy(0)->crc32 != mdata_copy(1)->crc32) {
>>                         fprintf(stderr,
>>                                 "Metadatas valid but not equal, use first one as default\n");
>>                         mdata_mod = update;
>>                 } else {
>> -                       valid_mdata = &mdata[1];
>> +                       valid_mdata = mdata_copy(1);
>>                 }
>>         }
>>
>> @@ -313,7 +328,7 @@ static int read_metadata(bool update)
>>                 fprintf(stderr,
>>                         "No metadata valid, use first one as default\n");
>>                 mdata_mod = update;
>> -               valid_mdata = &mdata[0];
>> +               valid_mdata = mdata_copy(0);
>>         }
>>
>>         if (valid_mdata->version == 2) {
>>
>> ---
>> base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
>> change-id: 20260818-fix_tools_fwumdata-cbef1098ff7e
>>
>> Best regards,
>> --
>> Patrice Chotard <patrice.chotard@foss.st.com>
>>

