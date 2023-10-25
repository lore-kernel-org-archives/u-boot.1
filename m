Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7395AC07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 12:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636C7879B1;
	Wed, 25 Oct 2023 14:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b="HyK0+B5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B748718F; Wed, 25 Oct 2023 09:59:24 +0200 (CEST)
Received: from mail.sensor-technik.de (mail.sensor-technik.de [80.150.181.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BB218718F
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 09:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex.michel@wiedemann-group.com
Received: from stwz1.stww2k.local (HELO stwz1.wiedemann-group.com)
 ([172.25.209.3])
 by mail.sensor-technik.de with ESMTP; 25 Oct 2023 09:59:22 +0200
Received: from stwz1.stww2k.local (localhost [127.0.0.1])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id 14BA9B5ABC;
 Wed, 25 Oct 2023 09:59:22 +0200 (CEST)
Received: from mail.wiedemann-group.com (stwexm.stww2k.local [172.25.2.110])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id 817E2B5AAC;
 Wed, 25 Oct 2023 09:59:12 +0200 (CEST)
Received: from stwexm.stww2k.local (172.25.2.110) by stwexm.stww2k.local
 (172.25.2.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Wed, 25 Oct
 2023 09:59:12 +0200
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.105)
 by stwexm.stww2k.local (172.25.2.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32 via Frontend Transport; Wed, 25 Oct 2023 09:59:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4+XkWnC+7y7kd8hMCro39gQWcp+VYZP9l610JVwSn+dZkN3kZdSSTJSc028OXOJW5PYI8JsDWJLKGlYrj7++m8n41BP6MbZFWkvpyt7QcRZyda4tudofgHpQBdiYDUhGVHp/Xv/6X1iRFN/S7yCzmGE26joPrjc4+O2i6k1X10YUKQrVgQeZEV2buVFaHTihq95bUmgZMiP7mmcKhBmxBkQNJ7dn7f6MHhMlGvCUGdLagujLr+TR1vY3LMEOI6i22iZjyn2Hjz6x+TRuJF2Jx6I7ki94kFpzCT9/ClB84+uRRkNc19Oh2ORFEk8rZbmbczQZ6mhWSBcPoOORQ+ouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnC/X8hbfIyWOAWhZOw4fH6ydLFO3gYzck829jG/JzE=;
 b=Y1ERcblWZdPQdnsXNngn8AgPJovAiFzKzYf/tZvr2Ek0xZkObKmiOWzJ7YYQWbLn/KZcvshksA+oYOJ3kjUzAlrWVGMjme9rUgVkyGKbFHfeQ/x90qKOuMBt1g/XEMBwtWLAKsnUm57OGkvZFoEbK2BKW1zVoTAytSiTa6exEDqBy/dQB9AlRdvzJCx2+T/POspN8nMaM9wNppxtXTxPf2PLg6WWyQ1IkPZkSBzpzvhHVU0Cy/+mdfRnjC66787LfZ261bI7iRNWWr/tUuzjfsmmFoLkOidtjtjfoXqa3HmpEONMAILEQjHXkiqzYtwdpTsfTv0Y2qKm39G9kyloIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiedemann-group.com; dmarc=pass action=none
 header.from=wiedemann-group.com; dkim=pass header.d=wiedemann-group.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwmm.onmicrosoft.com; 
 s=selector1-stwmm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnC/X8hbfIyWOAWhZOw4fH6ydLFO3gYzck829jG/JzE=;
 b=HyK0+B5UQABebX7FnkwIhv0psl9SnDQhE2Im61h37Tz3NwC9h7hGBvqhdq9ZImt6GRqXi4Yypc6YQJyzlXAjcfY7eip0KXeXMtWJLqzA2RVq/oya5bv30V3suh0uLCEpvt20zYYr+CSgSdTpyBBe62eSIv7ug2AIJAmPLna1k0w=
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48d::22)
 by AS8P250MB0329.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:37c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 07:59:05 +0000
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::3848:f440:3c65:5e82]) by AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::3848:f440:3c65:5e82%7]) with mapi id 15.20.6863.046; Wed, 25 Oct 2023
 07:59:05 +0000
From: Michel Alex <Alex.Michel@wiedemann-group.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH v2] misc: i2c_eeprom: consider pagesize when writing to eeprom
Thread-Topic: [PATCH v2] misc: i2c_eeprom: consider pagesize when writing to
 eeprom
Thread-Index: AQHaBxkfay3CNufpAUmSQMhUgsTnBg==
Date: Wed, 25 Oct 2023 07:59:05 +0000
Message-ID: <AS1P250MB06088A3DFC19C7673DB0F551A9DEA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
References: <AS1P250MB0608EFCD6443148D5D9837C6A9F8A@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20231024231543.GN496310@bill-the-cat>
In-Reply-To: <20231024231543.GN496310@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiedemann-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1P250MB0608:EE_|AS8P250MB0329:EE_
x-ms-office365-filtering-correlation-id: 19fcc874-44ff-4612-40bf-08dbd5304267
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WEgR7E4Qzd5shCvzKw7yp8xSF5ovRo1tRIqmJ///oWvQxjG1wugRYsMPFqjq2DBMAKwxFD8OE9wLkLMVuvLFn4j2I8KpaW3MaMObhqah9voU4ZH5hZUdzV+E/SidHOaEviZkM6JqGI0VoSHKUEHwFWnV8mTn8JYfWfVEd3uCOVwS0dnlTR/AmA8XbNQ+f6i02RsAUNyqRmeyAvBztlyuHqwYosQ8VWIOm7STtTvvPPBoDtvv/lwxHHv7hfYVHE2SOPoHe6q9AeWy9q/YJf8M2Vh7/6/yASUDvqAFQgNRcmv10HKtxFzNh2pCBLqJZQur6Gat3GXz/4I6nX4Pn0SzNIouK9LBB8ztVkHtyRGbwtppKDDwMdnX4RvP9jQRu1FYW+WcdMOJQzw6tfEuT9Spa3EBMDfvGcw02Zik7XpwwA990ETIpwYYiJ2iKGWSO2pgSJp4Wnm0b38p/8160KyGlNFEtZ4mBsMkGFtv87XY3EOKfN0uwJdJZBSbEc5eI7z3tIJDsj2aYBwrTzbfcblvnFDDtJfGm8PmeqoBdKOTwPQxWMPR8ru3n5yoKIU0lqp6vYXuDyXBiW/Oy/SLGcU99guXMFcWPwR82zY8fpJUCAmmsKHooByxyVMXKbRTFOsQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1P250MB0608.EURP250.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(136003)(39850400004)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(55016003)(71200400001)(83380400001)(8936002)(2906002)(26005)(52536014)(33656002)(8676002)(122000001)(38100700002)(4326008)(76116006)(7696005)(9686003)(6506007)(6916009)(316002)(478600001)(5660300002)(66556008)(66946007)(86362001)(64756008)(41300700001)(66476007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FewfcszoIVLZpsO+hgtQoZEL/VS8KVRic8NilhGE8uxXRkW1vxQh8BLbiIuq?=
 =?us-ascii?Q?PCRnFBN5dXLUoMkA+KARVrGgCGGM3g/SNWfY2vC+9LH9SdwnTSTqJaX6JREj?=
 =?us-ascii?Q?gtfYSjEaJ4SeWn3ku2OVSC0VYEXTPyGx+R5IKd/6fNDKaiwiaNC+kYaIl8i2?=
 =?us-ascii?Q?jEoGfEHE5q1l3wphHRrnzspE+b0c4ZUwc/eXop9PkynnHaMjo4WL+S8rMADV?=
 =?us-ascii?Q?ujgL9HFn8syBrW2mLJXCRE/IfP8kg/tQLeWdQQ/rMdQrv1Qo2k73AGuQt6Pl?=
 =?us-ascii?Q?zhfmruonrpjmKtob6z58yuYUirvmk0UZ1/IBq9VxKiXcdKjiaRU5WyF2V6Jx?=
 =?us-ascii?Q?wSs1XyDRvxxgSqkGn9Eu2d9KayCsinUNcNrr/nsUsfXqOH6qui+5lmW+y1kx?=
 =?us-ascii?Q?Xj0craNbzS/0qTJ55yVHqeDrqrYOptsvK/R0j7WaMLv44X7MGTeOtxlOC0Xk?=
 =?us-ascii?Q?hbXqTecYd7d25U3xLAHLrLS8SJ5+3fIhL4r07mERttzi6GqcH5VVhy+GFANm?=
 =?us-ascii?Q?yrsYfzdiA2ugjMBXTccGt5voLMkIPS4m9B7s1njkrc0FhdzXwIyslRKh/LyE?=
 =?us-ascii?Q?R6GIx/d4DgzmIa78IPw2p4ba3+Ywge3eKIaW0A+d9WXUDPfZdhVV1yZh7o/J?=
 =?us-ascii?Q?w4SLQdXF6LYtcH4HJ8vyqBPnG5aAGeDaTHsWygb20P50pMgjXokw3tdglp0o?=
 =?us-ascii?Q?SjNvBWGPs2eG/O+Bu77Zi3P1f+CL11Ef5VwOuMbLaTO3UINZa00RgcocTQti?=
 =?us-ascii?Q?PydnZOKbDbqU20UJuxQ0N4kF1fE7rfivBmAMKKntwDlND+GhmuWMSZSnDYZO?=
 =?us-ascii?Q?IwSJ05WU3oGp2MIr2XSnPdZGLXglNzE5J6e1Ymufz3wPZWCfhqJy98DePb4j?=
 =?us-ascii?Q?LzJ71Pagjr/7quk1xdzk9mAoFFG2mclegG7jaypPeNLSzTofO/CwEyUe1imE?=
 =?us-ascii?Q?9LkVZzEsWvbcAUw4bqY72YbpajJIjqTz5X/mhMI4bspXuWfN+8epeSJozdKl?=
 =?us-ascii?Q?f8ZpLQAocck+MFAAOzccv7GSuY2obnzeTS6aSC2au6XJux9KsNEIaLmfCA89?=
 =?us-ascii?Q?BLoFZ75ehmsjLOOUcjQeKgfvh/uM1T1KWZehPv3h2tiwvDO6HRsf2htvH6Yw?=
 =?us-ascii?Q?eYgeed/Nf8/7ifChVe/l3DtQ3DxcPv8q62R9JnFvABq4+E+N/eHKJjWORNNL?=
 =?us-ascii?Q?k3O/AyhE2R3ln3ITmmKFYZcpe/MY8BLe9KCdPwqsTvT7InI4dlcxiA2asAcj?=
 =?us-ascii?Q?JmgU7Ho8ab9amOBl0Aoa1/ZxxPhA+45T8rPnC1ZCNM0YliDmCjebG5JOVT72?=
 =?us-ascii?Q?NL4DuZcAX/0+Ygm7QReun9yempiC5gdPkbb8lF+o5Pw/VCa2hRROEUqHupxb?=
 =?us-ascii?Q?vWXHvjg6PZ61Q8o26j5sVDadddxhMN4DVIiqsBGikxTAdN7Sywsb2CbnHpaf?=
 =?us-ascii?Q?3wqx4TsgEgis3dsOj8dQl9eRaCvFD1nbKAJScysqO9SLV86H1RZH1dpnuMA5?=
 =?us-ascii?Q?ylfltKa3dl18sT90lnPiIwaKvuKGRC3DVLZm84MU/L/BNr9KbJBwcHXEuJ5w?=
 =?us-ascii?Q?HYio6e7uMrzIT6DZPKncuCJQK1eXs72OWC4hXWMR1uzRvwzcpi8nw7ZdL3aK?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ccs+wT1qWs1qYObRYvJiuJbDj0cshPGjgr1R3W8FMBsNZWV4sajrdzLE/C4TVIrHmBcVjrdcT89K1ID+NFrCjk9q+igaAD5omF/Imle4xampplmHxq6II0Y3t9PLe+87PcEcjXseUxmlKfU+HTMPVB/2DXZI7gE30BCzHAsd7jb4QDXknIoIvWy6HNzJnT6hvqH3NOnK0smZ+ac91AtXBXhqAhEhU55ZYfsIPCmyNGQdFQ0Yk6c+JXoFJk9nyq2LHr0aiiHRq/cB4pFEtuyH5sZTG1B42hjq/T3/3eOPh1c3G6TMWZPZKasVoi3cDRW0lhFeIOOJl/K8djE/ju3WdCRQxQpwOWjQdf1/bSbQmIZ2iyscWqRTO5WSXCunKHVPxnc41bHwdzXr14/jot+0ImVgxuG0UZA6QkJ+XBJ9fNVLy4BRgHQXmcPZ9h/39us3cL2y3Iz9dG3dJXd8amVkyOB7H6n9fzGSkG97anzmajt+RW0oJkxj/o2YwGMk+Rui+ueHyB2qC9WMXA/AFDMVpw20zy6mb2359Dvt7xvioUSkynbrIpsCIgGnhdeiaq+AFRwU3pwEtpEwGpPut5yvDVlh/lFjqt4ak6iPGGP6bdEgfGft3tnIzBBabIJl6duaBE3In7fP7ycjZkI0Di0oLSl2vYBv18Ba2vqzB8fEGsc0PqO2Sny9bFY+riTiIy7TITq2EJN19c1woS70ATpHJDuTF2/9/lDIRZS3GehSRWUb0BR6+63CU+vtHPP9FzMnEdkHOW9V33lfEZBfqqnFYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fcc874-44ff-4612-40bf-08dbd5304267
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 07:59:05.2032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f92d38a3-9c84-427f-afc3-aef091509c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vfSZf5N9+BtIoAtyGdZY3NPy5JD1ngFxsdwgRC/cIoiA43b9VGiBwgE4fjlvc+hBfu6w1dMvHYV+UMqXin6imdW49CXXsnP51HBxoDurT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB0329
X-C2ProcessedOrg: 71f8fb5e-29e9-40bb-a2d4-613e155b19df
X-TBoneOriginalFrom: Michel Alex <Alex.Michel@wiedemann-group.com>
X-TBoneOriginalTo: Tom Rini <trini@konsulko.com>
X-TBoneOriginalCC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
X-TBoneDomainSigned: false
X-Mailman-Approved-At: Wed, 25 Oct 2023 14:27:29 +0200
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

Calculate the maximum length of the buffer when writing
across the page boundary. If the buffer length (len)
exceeds the page boundary (pagesize), split it. Use this
length instead of comparing the length with the pagesize,
because if the write start address (offset) is not at the
beginning of a page and the page_offset + len is greater
than the page boundary (pagesize), the write operation
would overflow the current page and the behaviour can be
undefined (e.g. at24).

Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
---
Changes for v2:
- fixed deviations from checkpatch.pl
- improved commit message
---
 drivers/misc/i2c_eeprom.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/i2c_eeprom.c b/drivers/misc/i2c_eeprom.c
index bdd7e018cc..0eecbd07ba 100644
--- a/drivers/misc/i2c_eeprom.c
+++ b/drivers/misc/i2c_eeprom.c
@@ -60,6 +60,17 @@ static int i2c_eeprom_std_read(struct udevice *dev, int =
offset, uint8_t *buf,
        return dm_i2c_read(dev, offset, buf, size);
 }

+static int i2c_eeprom_len(unsigned int offset, unsigned int len, unsigned =
int pagesize)
+{
+       int page_offset =3D ((offset) & (pagesize - 1));
+       unsigned int maxlen =3D pagesize - page_offset;
+
+       if (len > maxlen)
+               len =3D maxlen;
+
+       return len;
+}
+
 static int i2c_eeprom_std_write(struct udevice *dev, int offset,
                                const uint8_t *buf, int size)
 {
@@ -67,7 +78,7 @@ static int i2c_eeprom_std_write(struct udevice *dev, int =
offset,
        int ret;

        while (size > 0) {
-               int write_size =3D min_t(int, size, priv->pagesize);
+               int write_size =3D i2c_eeprom_len(offset, size, priv->pages=
ize);

                ret =3D dm_i2c_write(dev, offset, buf, write_size);
                if (ret)
--
2.34.1

